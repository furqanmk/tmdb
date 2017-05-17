//
//  Double+TMDB.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
