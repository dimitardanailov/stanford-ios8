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
    
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypping {
            enter()
        }
        
        switch operation {
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $0 - $1 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    /**
    Source: http://stackoverflow.com/questions/29457720/compiler-error-method-with-objective-c-selector-conflicts-with-previous-declara
    */
    private func performOperation(operation: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func divide(firstNumber: Double, secondNumber: Double) -> Double {
        return firstNumber / secondNumber
    }
    var operandStack: Array<Double> = Array<Double>()

    @IBAction func enter() {
        userIsInTheMiddleOfTypping = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
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

