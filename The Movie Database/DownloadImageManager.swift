//
//  DownloadImageManager.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import UIKit

public class DownloadImageManager {
    
    /// Shared manager used for image downloading.
    public static var shared: DownloadManager<UIImage> {
        guard let s = _singleton else {
            _singleton = DownloadManager<UIImage>()
            return _singleton!
        }
        return s
    }
    static private var _singleton: DownloadManager<UIImage>?
    
}
