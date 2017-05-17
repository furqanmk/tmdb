//
//  Movie.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    var title: String?
    var overview: String?
    var released: String?
    var rating: Double?
    var adult: Bool?
    var posterUrl: String?
    var backdropUrl: String?
    
    init(json: JSON) {
        self.title = json["title"].string
        self.overview = json["overview"].string
        self.released = json["release_date"].string?.beautifulDate
        self.rating = json["popularity"].double?.roundTo(places: 1)
        self.adult = json["adult"].bool
        
        if let posterPath = json["poster_path"].string {
            self.posterUrl = "http://image.tmdb.org/t/p/w500\(posterPath)"
        }
        
        if let backdropPath = json["backdrop_path"].string {
            self.backdropUrl = "http://image.tmdb.org/t/p/w500\(backdropPath)"
        }
        
    }
}
