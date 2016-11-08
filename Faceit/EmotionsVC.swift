//
//  EmotionsVC.swift
//  Faceit
//
//  Created by gamma on 11/2/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import UIKit

class EmotionsVC: UIViewController {

  private let emotionalFaces: Dictionary<String,FacialExpression> = [
    "angry": FacialExpression(eyes: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
    "happy": FacialExpression(eyes: .Open, eyeBrows: .Normal, mouth: .Smile),
    "worried": FacialExpression(eyes: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
    "mischievous": FacialExpression(eyes: .Open, eyeBrows: .Furrowed, mouth: .Grin)
  ]
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    var destinationvc = segue.destination
    if let navcon = destinationvc as? UINavigationController {
      destinationvc = navcon.visibleViewController ?? destinationvc
    }
    if let facevc = destinationvc as? FaceVC {
      if let identifier = segue.identifier {
        if let expression = emotionalFaces[identifier] {
          facevc.expression = expression
          if let sendingButton = sender as? UIButton {
            facevc.navigationItem.title = sendingButton.currentTitle
          }
        }
      }
    }
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    let instance = getEmotionsMVCinstanceCount()


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
