//
//  MovieList.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MovieManagerDelegate {
    func didLoadMovies(noResults: Bool)
}

class MovieManager {
    static let shared = MovieManager()
    private init() { }
    
    var delegate: MovieManagerDelegate?
    
    var list: [Movie] = [ ]
    var request: DownloadRequest<JSON>!
    
    func search(string query: String) {
        if request != nil {
            request.cancel()
        }
        self.request = DownloadRequest<JSON>(path: "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)",
        progress: nil,
        success: { [weak self] json in
            guard let movieItems = json["results"].array else {
                return
            }
            self?.list.removeAll()
            for item in movieItems {
                let movie = Movie(json: item)
                self?.list.append(movie)
            }
            self?.delegate?.didLoadMovies(noResults: movieItems.count == 0)
            History.addItem(string: query)
        },
        failure: { error in
            print("Error loading movies.")
        })
    }
    
    func clear() {
        list = [ ]
        DownloadImageManager.shared.cache.clearCache()
    }
}
