//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by Giordano Scalzo on 08/12/2014.
//  Copyright (c) 2014 Effective Code Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rangeLbl: UILabel!
    @IBOutlet weak var numberTxtField: UITextField!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var numGuessesLbl: UILabel!
    private var lowerBound = 0
    private var upperBound = 100
    private var numGuesses = 0
    private var secretNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberTxtField.becomeFirstResponder()
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onOkPressed(sender: AnyObject) {
        let number = numberTxtField.text.toInt()
        if let number = number {
            selectectNumber(number)
        } else {
            var alert = UIAlertController(title: nil, message: "Enter a number", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func selectectNumber(number: Int){
        if number == secretNumber {
            var alert = UIAlertController(title: nil, message: "You won in \(numGuesses) guesses!",
                preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { cmd in
                self.reset()
                self.numberTxtField.text = ""
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        } else if number < secretNumber {
            lowerBound = max(lowerBound, number)
            messageLbl.text = "Your last guess was too low"
        } else if number > secretNumber {
            upperBound = min(upperBound, number)
            messageLbl.text = "Your last guess was too high"
        }
        numberTxtField.text = ""
        numGuesses++
        renderRange()
        renderNumGuesses()
    }
    
    private func extractSecretNumber() {
        let diff = upperBound - lowerBound
        let randomNumber = Int(arc4random_uniform(UInt32(diff)))
       secretNumber = randomNumber + Int(lowerBound)
    }

    private func renderRange() {
        rangeLbl.text = "\(lowerBound) and \(upperBound)"
    }

    private func renderNumGuesses() {
        numGuessesLbl.text = "Number of Guesses: \(numGuesses)"
    }

    private func resetData() {
        lowerBound = 0
        upperBound = 100
        numGuesses = 0
    }

    private func resetMsg() {
        messageLbl.text = ""
    }

    private func reset(){
        resetData()
        renderRange()
        renderNumGuesses()
        extractSecretNumber()
        resetMsg()
    }
}

