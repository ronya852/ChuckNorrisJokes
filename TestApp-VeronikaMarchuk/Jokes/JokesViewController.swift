//
//  JokesViewController.swift
//  TestApp-VeronikaMarchuk
//
//  Created by RonchPonchPomkins on 23/1/2021.
//

import Foundation
import UIKit

class JokesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyScreenLabel: UILabel!
    @IBOutlet weak var jokeImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var jokes = [Joke]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.isHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func loadButtonAction(_ sender: Any) {
        let request = textField.text
        let requestInt: Int = Int(request!) ?? 0
        if request == nil || requestInt == 0 {
            emptyTextFieldAlert()
            stopAnimating()
        } else {
            startAnimating()
            jokes.removeAll()
            tableView.reloadData()
            emptyScreenLabel.isHidden = true
            DataService.shared.getJokes(requestInt) { [weak self] (requestedJokes) in
                self?.jokes = requestedJokes
                DispatchQueue.main.async {
                    let resultCount = requestedJokes.count
                    if resultCount == 0 {
                        self?.errorAlert()
                    }
                    self?.tableView.reloadData()
                    self?.stopAnimating()
                }
            }
        }
    }
    
    func errorAlert() {
        let archiveMenu = UIAlertController(title: nil, message: "Error. Try again", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        archiveMenu.addAction(cancelAction)
        
        self.present(archiveMenu, animated: true, completion: nil)
    }
    
    func emptyTextFieldAlert() {
        let archiveMenu = UIAlertController(title: nil, message: "Enter the number of jokes", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        archiveMenu.addAction(cancelAction)
        
        self.present(archiveMenu, animated: true, completion: nil)
    }
}

extension JokesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "JokesTableViewCell", for: indexPath) as? JokesTableViewCell {
            cell.updateCell(joke: jokes[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension JokesViewController {
    
    func startAnimating() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        loadButton.isEnabled = false
    }
    
    func stopAnimating() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        loadButton.isEnabled = true
    }
}

extension JokesViewController {
    
    func configureKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(JokesViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(JokesViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            view.layoutIfNeeded()
            bottomConstraint.constant = keyboardHeight + 10
            
            UIView.animate(withDuration: 5) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 10
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(JokesViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
