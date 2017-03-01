//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {

    var HangManM = HangmanModel()
    let image1 = UIImage(named: "hangman1.jpg")
    
    let image2 = UIImage(named: "hangman2.jpg")
    let image3 = UIImage(named: "hangman3.jpg")
    let image4 = UIImage(named: "hangman4.jpg")
    let image5 = UIImage(named: "hangman5.jpg")
    let image6 = UIImage(named: "hangman6.jpg")
    let image7 = UIImage(named: "hangman7.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        HangManM.setPhrase(phr: phrase)
        print(phrase)
        CurrentGameState.text = HangManM.underscore(str: phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moreThan1() {
        let title = "Error"
        let message = "You can only guess 1 letter at a time"
        let OkText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let OKbutton = UIAlertAction(title: OkText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(OKbutton)
        present(alert, animated: true, completion: nil)
    }
    
    func failState() {
        let title = "You Lose!"
        let message = "You have no more guesses left"
        let OkText = "Play again"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let OKbutton = UIAlertAction(title: OkText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(OKbutton)
        present(alert, animated: true, completion: nil)
        HangManM.resetGuesses()
        UpdatedGuesses.text = "Guesses: " + String(HangManM.numGuesses)
        viewDidLoad()
        CurrentGameState.text = HangManM.underscore(str: HangManM.phrase)
        hmImage.image = UIImage(named: "hangman1.jpg")
    }
    
    func winState() {
        let title = "You Win!"
        let message = "You guessed the correct word"
        let OkText = "Play again"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let OKbutton = UIAlertAction(title: OkText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(OKbutton)
        present(alert, animated: true, completion: nil)
        HangManM.resetGuesses()
        UpdatedGuesses.text = "Guesses: " + String(HangManM.numGuesses)
        viewDidLoad()
        CurrentGameState.text = HangManM.underscore(str: HangManM.phrase)
        hmImage.image = UIImage(named: "hangman1.jpg")
    }
    
    @IBOutlet weak var hmImage: UIImageView!
    
    @IBOutlet weak var CurrentGameState: UILabel!
    
    @IBOutlet weak var UpdatedGuesses: UILabel!
    
    @IBOutlet weak var TypedGuess: UITextField!
    
    @IBAction func GuessButton(_ sender: UIButton) {
        let correctPhrase = HangManM.phrase
        let gs = TypedGuess.text
        let spacing = HangManM.getSpaces()
        if gs!.characters.count > 1 {
            moreThan1()
        }
        
        if HangManM.containsLetter(guess: gs, phr: correctPhrase) {
            var indexes: [Int] = []
            for i in 0...correctPhrase.characters.count {
                if HangManM.containsLetter(guess: gs, phr: correctPhrase.substring(atIndex: i)) {
                    indexes.append(i)
                }
            }
    
            for i in indexes {
                if spacing.isEmpty || i < spacing[0]  {
                    CurrentGameState.text = HangManM.changeInstances(myString: CurrentGameState.text, index: i*2, newChar: Character(gs!))
                } else if i > spacing[0] && i < spacing[1] {
                    CurrentGameState.text = HangManM.changeInstances(myString: CurrentGameState.text, index: i*2-1, newChar: Character(gs!))
                } else if i > spacing[1] && i < spacing[2] {
                     CurrentGameState.text = HangManM.changeInstances(myString: CurrentGameState.text, index: i*2-2, newChar: Character(gs!))
                } else if i > spacing[2]  {
                    CurrentGameState.text = HangManM.changeInstances(myString: CurrentGameState.text, index: i*2-3, newChar: Character(gs!))
                }
            }
        } else {
            if gs!.characters.count == 1 {
                HangManM.incrementGuess()
                UpdatedGuesses.text = "Guesses: " + String(HangManM.numGuesses)
                hmImage.image = UIImage(named: "hangman" + String(HangManM.numGuesses + 1) + ".jpg")
            }
        }
        
        if CurrentGameState.text!.lowercased().removingWhitespaces() == correctPhrase.lowercased().removingWhitespaces() {
            winState()
        }
        
        if HangManM.numGuesses == 6 {
            failState()
        }
    }
    
    @IBAction func startGameOver(_ sender: UIButton) {
        HangManM.resetGuesses()
        UpdatedGuesses.text = "Guesses: " + String(HangManM.numGuesses)
        viewDidLoad()
        CurrentGameState.text = HangManM.underscore(str: HangManM.phrase)
        hmImage.image = UIImage(named: "hangman1.jpg")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
