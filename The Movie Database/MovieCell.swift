//
//  MovieCell.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import Foundation

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageCoverView: UIView!
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet weak var releasedHeading: UILabel!
    @IBOutlet private weak var releasedLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var adultLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                
                if let backdropUrl = movie.backdropUrl {
                    print(backdropUrl)
                    backdropImageView.setImage(url: backdropUrl)
                }
                
                if let posterUrl = movie.posterUrl {
                    posterImageView.setImage(url: posterUrl)
                }
                
                titleLabel.text = movie.title
                overviewLabel.text = movie.overview
                releasedLabel.text = movie.released
                ratingLabel.text = "\(movie.rating!)"
                adultLabel.isHidden = !movie.adult!
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let standardHeight = LayoutConstants.Cell.standardHeight
        let featuredHeight = LayoutConstants.Cell.featuredHeight
        
        let delta = 1 - ((featuredHeight - frame.height) / (featuredHeight - standardHeight))
        overviewLabel.alpha = delta
        releasedHeading.alpha = delta
        releasedLabel.alpha = delta
    }
    
}
