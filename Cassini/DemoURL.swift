//
//  DemoURL.swift
//  Cassini
//
//  Created by gamma on 11/2/16.
//  Copyright © 2016 Beau Galbraith. All rights reserved.
//

import Foundation
struct DemoURL {
  static let Stanford = "http://stanford.edu/about/images/intro_about.jpg"
  static let NASA = [
    "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
    "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
    "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
  ]
  
  static func NASAImageNamed(imageName: String?) -> URL? {
    if let urlstring = NASA[imageName ?? ""] {
      return URL(string: urlstring)
    } else {
      return nil
    }
  }
}
