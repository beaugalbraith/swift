//
//  EyeView.swift
//  Faceit
//
//  Created by gamma on 11/5/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import Foundation
import UIKit
class EyeView : UIView {
  var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
  var color: UIColor = UIColor.blue { didSet { setNeedsDisplay() } }
  var eyesOpen: Bool {
    get {
      return _eyesOpen
    }
    set {
      UIView.transition(with: self, duration: 0.2, options: [.transitionFlipFromTop,.curveLinear], animations: {
        self._eyesOpen = newValue
      }, completion: nil)
    }
  }
  var _eyesOpen: Bool = true { didSet { setNeedsDisplay() } }
  
  override func draw(_ rect: CGRect) {
    var path: UIBezierPath!
    if eyesOpen {
      path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth/2, dy: lineWidth/2))
    } else {
      path = UIBezierPath()
      path.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
      path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
      
    }
    path.lineWidth = lineWidth
    color.setStroke()
    path.stroke()
  }
}
