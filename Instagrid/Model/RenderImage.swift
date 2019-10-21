//
//  RenderImage.swift
//  Instagrid
//
//  Created by Alexandre Goncalves on 11/10/2019.
//  Copyright © 2019 Alexandre Goncalves. All rights reserved.
//

import Foundation
import UIKit

class RenderImage {
  
  /// This method allows us to create a UIImage from the view choosen
  static func createImage(from view: UIView ) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
    let image = renderer.image { contex in
      view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    }
    return image
  }
}
