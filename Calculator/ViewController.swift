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
    
    var brain = CalculatorBrain()
    
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
    
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypping {
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    var operandStack: Array<Double> = Array<Double>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text! = "\(newValue)"
            userIsInTheMiddleOfTypping = false
        }
    }
}

