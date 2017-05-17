//
//  DownloadSettings.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation

class DownloadSettings {
    public static var requestTimeoutSeconds = 60.0
    public static var maximumSimultaneousDownloads = 50
    public static var requestCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
}
