//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by dimitar on 8/24/15.
//  Copyright (c) 2015 dimityr.danailov. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op: Printable
    {
        case Opperand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String {
            get {
                switch self {
                case .Opperand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = Array<Op>()
    
    private var knownOps = Dictionary<String, Op>()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("x", *))
        learnOp(Op.BinaryOperation("÷") { $1 / $0 })
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−") { $1 - $0 })
        learnOp(Op.UnaryOperation("√", sqrt))
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remaingOps: [Op]) {
        if !ops.isEmpty {
            // Immutable value of type '[CalculatorBrain.Op]' only has mutating members named 'removeLast'
            // ops is stub and can be only read only
            // let op = ops.removeLast()
            
            // Create copy of ops
            var remainingsOps = ops
            let op = remainingsOps.removeLast()
            
            switch op {
            case .Opperand(let operand):
                return (operand, remainingsOps)
            // _ is not carry about
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingsOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remaingOps)
                }
            case .BinaryOperation(_, let operation):
                let firstOperandEvaluation = evaluate(remainingsOps)
                
                if let firstOperand = firstOperandEvaluation.result {
                    let secondOperandEvaluation = evaluate(firstOperandEvaluation.remaingOps)
                    
                    if let secondOperand = secondOperandEvaluation.result {
                        return (operation(firstOperand, secondOperand), secondOperandEvaluation.remaingOps)
                    }
                }
            }
        }
        
        
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        println("\(opStack)= \(result) with \(remainder) left over")
        
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Opperand(operand))
        
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        
        return evaluate()
    }
}
