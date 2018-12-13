//
//  TableViewCell.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import UIKit
import SDWebImage

class UpcomingMoviesTableViewCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieVote: UILabel!
    @IBOutlet weak var star: UIImageView!
    
    
    static let reuseIdentifier = "UpcomingMoviesTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        star.isHidden = true
        movieVote.isHidden = true
        self.backgroundColor = .clear
        self.contentView.backgroundColor = cellBackgroundColor
        movieCover.contentMode = .scaleAspectFit
        movieCover.layer.shadowColor = UIColor.black.cgColor
        movieCover.layer.shadowOpacity = 1
        movieCover.layer.shadowOffset = CGSize.zero
        movieCover.layer.shadowRadius = 1
    }
    
    
    func configureSelf(withModel model: UpcomingMovie) {
        movieTitle.text = model.title
        movieYear.text = model.releaseDate
        
        if model.voteAverage != 0 {
            movieVote.isHidden = false
            star.isHidden = false
            movieVote.text = String(describing: model.voteAverage)
        }
        
        if let path = model.posterPath {
            let posterPath =  "https://image.tmdb.org/t/p/w500\(path)"
            let url = URL(string: posterPath)!
            movieCover.sd_setImage(with: url, completed: nil)
        } else {
            movieCover.image = UIImage(named: "posterPlaceholder1.png")
        }
    }
}

