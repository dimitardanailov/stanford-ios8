//
//  ViewController.swift
//  Calculator
//
//  Created by dimitar on 5/17/15.
//  Copyright (c) 2015 dimityr.danailov. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypping: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        // let - constant stored properties
        // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html
        let digit  = (sender.currentTitle)!
        println("digit = \(digit)")
        
        if (userIsInTheMiddleOfTypping) {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypping = true
        }
    }
}

