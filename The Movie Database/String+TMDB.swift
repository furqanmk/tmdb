//
//  String+TMDB.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation

extension String {
    private func tmdbDate(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
    var beautifulDate: String? {
        guard let date = tmdbDate(string: self) else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
