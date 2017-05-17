//
//  UIImageView+TMDB.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import UIKit

public extension UIImageView {
    public func setImage(url: String) {
        DownloadImageManager.shared.fetch(url: url, progress: nil, success: { (image) in
            self.image = image
        }) { (error) in
            print(error)
        }
    }
}
