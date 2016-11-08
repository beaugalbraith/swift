//
//  ViewController.swift
//  Cassini
//
//  Created by gamma on 11/2/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import UIKit

class ImageController: UIViewController, UIScrollViewDelegate {
  let back = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: nil, action: nil)

  @IBOutlet weak var spinnerView: UIActivityIndicatorView!
  @IBOutlet weak var scrollView: UIScrollView! {
    didSet {
      scrollView.contentSize = imageView.frame.size
      scrollView.delegate = self
      scrollView.minimumZoomScale = 0.03
      scrollView.maximumZoomScale = 1.0 // unnecessary because this is the default
      
    }
  }
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  private var imageView = UIImageView()
  
  var imageURL: URL? {
    didSet {
      image = nil
      if view.window != nil {
        fetchImage()
      }
    }
  }
  
  // Where you can fire expensive operations
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if image == nil {
      fetchImage()
    }
  }
  private func fetchImage() {
    if let url = imageURL {
      let global = DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass)
      NSLog("global.async{}")
      spinnerView?.startAnimating()
      global.async {
        do {
          let imageData = try Data(contentsOf: url)
          print("got image data on global user initiated queue")
          if url == self.imageURL {
            DispatchQueue.main.async {
              print("putting image data back on main queue to update UI")
              self.image = UIImage(data: imageData)
            }
          } else {
              print("did not update ui with image because requested image has chagned: url != imageURL")
          }
        } catch {
            self.spinnerView?.stopAnimating()
            print("couldn't make data")
        }
      }
    }
  
  }

  private var image: UIImage? {
    get {
      return imageView.image
    }
    set {
      imageView.image = newValue
      imageView.sizeToFit()
      scrollView?.contentSize = imageView.frame.size
      spinnerView?.stopAnimating()
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    //view.addSubview(scrollView)
    scrollView.addSubview(imageView)
  }

}

