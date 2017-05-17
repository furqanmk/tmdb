//
//  Movie.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var overview: String
    var released: String
    var popularity: Double
    var voteAvg: Int
    var adult: Bool
    var posterUrl: String
    var backdropUrl: String
    
    init(json: ) {
        self.title = json
    }
}
