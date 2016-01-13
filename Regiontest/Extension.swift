//
//  Extension.swift
//  Regiontest
//
//  Created by Timothy Andres (i7679245) on 11/01/2016.
//  Copyright © 2016 Timbology. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



func downloadImage(url: String, completion: (image: UIImage) -> Void) {
    Alamofire.request(.GET, url).response { _, _, data, _ in
        if let data = data {
            let image = UIImage(data: data)
            print(url)
            completion(image: image!)
        }
    }
}

