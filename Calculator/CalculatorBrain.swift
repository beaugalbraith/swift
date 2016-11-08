//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by gamma on 10/21/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import Foundation

class CalculatorBrain {
  private var accumulator = 0.0

  // TODO
  /*
 5. Add a String property to your CalculatorBrain called description which returns a description of the sequence of operands and operations that led to the value returned by result. “=“ should never appear in this description, nor should “...”.
 */
  private var _description: String = ""
  var description: String {
    get {
      return _description
    }
    
  }
  var isPartialResult: Bool {
    get {
      return (pending != nil)
    }
  }
  /*
 6. Add a Bool property to your CalculatorBrain called isPartialResult which returns whether there is a binary operation pending (if so, return true, if not, false).
 */
  
  var operations : [String: Operation] = [
    "π" : Operation.Constant(M_PI),
    "e" : Operation.Constant(M_E),
    "×" : Operation.BinaryOperation({ $0 * $1 }),
    "-" : Operation.BinaryOperation({ $0 - $1 }),
    "÷" : Operation.BinaryOperation({ $0 / $1 }),
    "+" : Operation.BinaryOperation({ $0 + $1 }),
    "=" : Operation.Equals,
    "cos" : Operation.UnaryOperation(cos),
    "sin" : Operation.UnaryOperation(sin),
    "C" : Operation.Constant(0.0),
    "%" : Operation.UnaryOperation({$0 / 100}),
    "∓" : Operation.UnaryOperation({-$0}),
    "x²" : Operation.UnaryOperation({$0 * $0}),
    "ξ" : Operation.Random,
    "√" : Operation.UnaryOperation({sqrt($0)})
  ]
  
  enum Operation {
    case Constant(Double)
    case UnaryOperation((Double) -> (Double))
    case BinaryOperation((Double, Double) -> (Double))
    case Random
    case Equals
    
  }
  
  func setOperand(operand: Double) {
    _description.append("\(operand) ")
    accumulator = operand
  }
  
  func performOperation(symbol: String) {
    // If operation is clear then we reset description
    if symbol == "C" {
      _description = ""
    } else if symbol == "=" {
      _ = description
    } else {
      _description.append("\(symbol) ")
    }
    if let operation = operations[symbol] {
      switch operation {
      case .Constant(let value):
        accumulator = value
      case .BinaryOperation(let function):
        executePendingBinaryOperation()
        pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
      case .UnaryOperation(let function): accumulator = function(accumulator)
      case .Random():
        let n = arc4random_uniform(1000000000)
        accumulator = Double(n)/1000000000
      case .Equals: executePendingBinaryOperation()
        
      }
    }
  }
  func addUnaryOperation(symbol: String, operation: @escaping (Double) -> Double) {
    operations[symbol] = Operation.UnaryOperation(operation)
  }
  private func executePendingBinaryOperation() {
    if pending != nil {
      accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
      pending = nil
    }
  }
  private var pending: PendingBinaryOperationInfo?
  
  private struct PendingBinaryOperationInfo {
    var binaryFunction: (Double, Double) -> Double
    var firstOperand: Double
    
  }
  
  var result: Double {
    get { return accumulator }
  }
  
  
}
