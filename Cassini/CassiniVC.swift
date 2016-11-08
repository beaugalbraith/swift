//
//  CassiniVC.swift
//  Cassini
//
//  Created by gamma on 11/2/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import UIKit

class CassiniVC: UIViewController, UISplitViewControllerDelegate {
  let back = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)

  @IBAction func showImage(_ sender: UIButton) {
    if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageController {
      let imageName = sender.currentTitle
      ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
      ivc.title = imageName
    } else {
      performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
    }
  }
  
  // My storyboard constants
  private struct Storyboard {
    static let ShowImageSegue = "showImage"
    
  }
  override func awakeFromNib() {
    splitViewController?.delegate = self

  }
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    if primaryViewController.contentViewController == self {
      if let ivc = secondaryViewController.contentViewController as? ImageController, ivc.imageURL == nil {
        return true
      }
    }
    return true
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Storyboard.ShowImageSegue {
      if let ivc = segue.destination.contentViewController as? ImageController {
        let imageName = (sender as? UIButton)?.currentTitle
        ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
        ivc.title = imageName
      }
    }
  }
}
extension UIViewController {
  
  var contentViewController: UIViewController {
    if let navcon = self as? UINavigationController {
      return navcon.visibleViewController ?? self
    } else {
      return self
    }
  }
}
