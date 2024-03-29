//
//  ImageModel.swift
//  Instagrid
//
//  Created by Alexandre Goncalves on 21/10/2019.
//  Copyright © 2019 Alexandre Goncalves. All rights reserved.
//

import Foundation

/// This class is used to manage an image from a model
class ImageModel {
  
  /// A dictionnary used to store the URL of the selected images. The keys used to retrieve the URLs are the button's tag
  var imageDict: [Int : URL] = [:]
  
  /// This functions returns an URL for the specified tag
  func getImageURLFrom(tag: Int) -> URL? {
    if let imageURL = imageDict[tag] {
      return imageURL
    }
    return nil
  }
  
}
