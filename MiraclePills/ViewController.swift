//
//  ViewController.swift
//  MiraclePills
//
//  Created by gamma on 11/8/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
  @IBOutlet weak var scrollView: UIScrollView!
  @IBAction func buyNow(_ sender: UIButton) {
  }
  @IBOutlet weak var contentStack: UIStackView!
  @IBOutlet weak var statePicker: UIPickerView!
  @IBOutlet weak var changeState: UIButton!
  @IBAction func chooseState(_ sender: UIButton) {
    statePicker.isHidden = false
  }
  var states = [
  "Alabama",
  "Alaska",
  "California",
  "Nevada",
  "Texas",
  "Wyoming"
  ]
  override func viewDidLoad() {
    super.viewDidLoad()
    statePicker.delegate = self
    statePicker.dataSource = self
    
    
  }
  @IBOutlet var swipeGestureRecognizer: UISwipeGestureRecognizer!

  override func viewDidAppear(_ animated: Bool) {
    scrollView.contentSize.width = view.frame.size.width
    
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return states.count
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return states[row]
  }
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    changeState.setTitle(states[row], for: UIControlState.normal)
    statePicker.isHidden = true
  }
  
}

