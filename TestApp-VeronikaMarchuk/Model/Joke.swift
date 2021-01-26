//
//  JokesModel.swift
//  TestApp-VeronikaMarchuk
//
//  Created by RonchPonchPomkins on 23/1/2021.
//

import Foundation

class Joke: Codable {
    
    var joke: String? = nil
    
    init(joke: String) {
        self.joke = joke
    }
}
