//
//  JokesTableViewCell.swift
//  TestApp-VeronikaMarchuk
//
//  Created by RonchPonchPomkins on 23/1/2021.
//

import UIKit

class JokesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        jokeLabel.text = nil
    }

    func updateCell(joke: Joke) {
        let string = joke.joke?.replacingOccurrences(of: "&quot;", with: "\"")
        jokeLabel.text = string
    }
}

