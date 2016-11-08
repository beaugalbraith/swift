//
//  ViewController.swift
//  Faceit
//
//  Created by gamma on 11/2/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import UIKit

class FaceVC: UIViewController {
  @IBAction func toggleEyes(_ recognizer: UITapGestureRecognizer) {
    if recognizer.state == .ended {
      switch expression.eyes {
      case .Open: expression.eyes = .Closed
      case .Closed: expression.eyes = .Open
      case .Squinting: break
      }
    }
  }
  @IBOutlet weak var faceView: FaceView! {
    didSet {
      faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(recognizer:))))
      
      let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceVC.increaseHappiness))
      happierSwipeGestureRecognizer.direction = .up
      faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
      
      let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceVC.decreaseHappiness))
      sadderSwipeGestureRecognizer.direction = .down
      faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
      updateUI()
    }
  }
  struct Animations {
    static let ShakeAngle = CGFloat(M_PI/6)
    static let ReturnAngle = -(Animations.ShakeAngle)*2
    static let ShakeDuration = 0.4
  }
  func reaturnShake() {
    UIView.animate(withDuration: Animations.ShakeDuration, animations: { self.faceView.transform = self.faceView.transform.rotated(by: Animations.ReturnAngle) } )
  }
  @IBAction func headShake(_ sender: UITapGestureRecognizer) {
    UIView.animate(withDuration: Animations.ShakeDuration, animations: {
      self.faceView.transform = self.faceView.transform.rotated(by: Animations.ShakeAngle)
    } )
    self.reaturnShake()

    //UIView.animate(withDuration: Animations.ShakeDuration, animations: { self.faceView.transform = self.faceView.transform.rotated(by: Animations.ReturnAngle) } )
    }
  
  // MARK: Model
  var expression: FacialExpression = FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Frown) { didSet { updateUI() } }

  func increaseHappiness() { expression.mouth = expression.mouth.happierMouth() }
  func decreaseHappiness() { expression.mouth = expression.mouth.sadderMouth() }

  private var mouthCurvatures = [FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1.0, .Smirk: -0.5, .Neutral: 0.0]
  private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]

  private func updateUI() {
    if faceView != nil {
      switch expression.eyes {
      case .Open: faceView.eyesOpen = true
      case .Closed: faceView.eyesOpen = false
      case .Squinting: faceView.eyesOpen = false
      }
    
    faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
  }
  let instance = getFaceMVCinstanceCount()
}

