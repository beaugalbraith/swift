//
//  ViewController.swift
//  Calculator
//
//  Created by gamma on 10/21/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var descText: UITextView!
  @IBAction func touchEqual(_ sender: UIButton) {
  }
  private var brain = CalculatorBrain()
  
  private var userIsTyping = false
  
  private var displayValue: Double {
    get { return Double(displayTotal.text!)! }
    set { displayTotal.text = String(newValue) }
  }
  
  @IBOutlet private weak var displayTotal: UILabel!
  @IBAction private func touchOperation(_ sender: UIButton) {
    if userIsTyping {
      brain.setOperand(operand: displayValue)
      userIsTyping = false
    }
    if let symbol = sender.currentTitle {
      brain.performOperation(symbol: symbol)
    }
    displayValue = brain.result
    print("pending: \(brain.isPartialResult)")
    if !brain.isPartialResult {
      descText.text = brain.description
    }

  }
  
  @IBAction private func touchDigit(_ sender: UIButton) {
    let digit = sender.currentTitle!
    print("touched \(digit) digit")
    if userIsTyping {
      let currentDisplay = displayTotal.text!
      displayTotal.text = currentDisplay + digit
    } else {
      displayTotal.text = digit
    }
    userIsTyping = true
    print("pending: \(brain.isPartialResult)")

  }
  override func viewDidLoad() {
    super.viewDidLoad()
    brain.addUnaryOperation(symbol: "Z") {[weak me = self] in
      me?.displayTotal.textColor = UIColor.red
      return sqrt($0)
    }
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  

}
