//
//  BlinkingFaceVC.swift
//  Faceit
//
//  Created by gamma on 11/5/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import UIKit

class BlinkingFaceVC: FaceVC {
  var blinking: Bool = false {
    didSet {
      startBlink()
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()

    blinking = true
  }
  override func viewWillDisappear(_ animated: Bool) {
    blinking = false
  }
  override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  // Dispose of any resources that can be recreated.
  }

  private struct BlinkRate {
    static let ClosedDuration = 0.4
    static let OpenDuration = 2.5
  }
  func startBlink() {
    if blinking {
      faceView.eyesOpen = false
      Timer.scheduledTimer(timeInterval: BlinkRate.ClosedDuration, target: self, selector: #selector(self.endBlink), userInfo: nil, repeats: false)
    }
  }
  func endBlink() {
    faceView.eyesOpen = true
    Timer.scheduledTimer(timeInterval: BlinkRate.OpenDuration, target: self, selector: #selector(self.startBlink), userInfo: nil, repeats: false)
  }

}
