//
//  DataService.swift
//  TestApp-VeronikaMarchuk
//
//  Created by RonchPonchPomkins on 26/1/2021.
//

import Foundation
import UIKit

let baseURL = "http://api.icndb.com/jokes/random/"

class DataService {
    
    static let shared = DataService()
    
    func getRequest(path: String?, closure: ((_ data: Data?)->())?) {
        
        guard let path = path, let url = URL(string: path) else {
            closure?(nil)
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            closure?(data)
        }.resume()
    }
    
    func getJokes(_ searchRequest: Int, complition: @escaping ([Joke])->()) {
        
        var jokes = [Joke]()
        let path = "\(baseURL)\(searchRequest)"
        
        getRequest(path: path) { (data) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    if let jokesResults = json["value"] as? NSArray {
                        
                        for joke in jokesResults {
                            if let jokeAttibute = joke as? [String: AnyObject] {
                                guard let jokeText = jokeAttibute["joke"] as? String else { return }
                                let newJoke = Joke(joke: jokeText)
                                jokes.append(newJoke)
                            }
                        }
                        complition(jokes)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
