//
//  WebViewViewController.swift
//  TestApp-VeronikaMarchuk
//
//  Created by RonchPonchPomkins on 23/1/2021.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, UITextFieldDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "API"
        webView.navigationDelegate = self
        self.activityIndicator.startAnimating()
        let urlString = "http://www.icndb.com/api/"
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        webView.load(request)

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
