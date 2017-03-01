//
//  HangmanModel.swift
//  Hangman
//
//  Created by Cathy Pham Le on 2/26/17.
//  Copyright © 2017 Shawn D'Souza. All rights reserved.
//

import Foundation

class HangmanModel {
    
    var phrase: String = ""
    var numGuesses = 0
    
    func setPhrase(phr : String) {
        phrase = phr
    }
    
    func underscore(str : String) -> String {
        var underS: String = ""
        for i in str.characters {
            if i != " " {
                underS += "_ "
            } else {
                underS += " "
            }
        }
        return underS
    }
    
    func getSpaces(str : String) -> [Int] {
        var spaces: [Int] = []
        for i in 0...phrase.characters.count {
            if phrase.substring(atIndex: i) == " " {
                spaces.append(i)
            }
        }
        return spaces
    }
    
    func containsLetter(guess: String?, phr: String?) -> Bool {
        return phr!.lowercased().range(of: guess!.lowercased()) != nil
    }
    
    func changeInstances(myString: String?, index: Int?, newChar: Character?) -> String {
        var chars = Array(myString!.characters)
        chars[index!] = newChar!
        let modifiedString = String(chars)
        return modifiedString
    }
    
    func incrementGuess() {
        numGuesses += 1
    }
    
    func resetGuesses() {
        numGuesses = 0
    }

}
