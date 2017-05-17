//
//  DownloadError.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation

public enum DownloadError {
    case invalidUrl
    case invalidResponse
    case not200
    case other(error: Error?)
}
