//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import UIKit
import CoreData
class DetailViewController: UIViewController {
    @IBOutlet weak var buttonFavorites: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    var detailModel: UpcomingMovie!
    var favDetailModel: FavoritesMO!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = detailModel.posterPath {
            let posterPath =  "https://image.tmdb.org/t/p/w500\(path)"
            let url = URL(string: posterPath)!
            movieCover.sd_setImage(with: url, completed: nil)
        } else {
            movieCover.image = UIImage(named: "posterPlaceholder1.png")
        }
        textView.text = detailModel.overview
        titleLabel.text = detailModel.title
    }
    @IBAction func closeButton(_ sender: UIButton) {
         presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonFavorites(_ sender: UIButton) {
        let context = PersistanceService.shared
            .persistentContainer
            .newBackgroundContext()
        do {
                buttonFavorites.setImage(UIImage(named: "like"), for: .normal)
            _ = FavoritesMO.createOrUpdate(title: detailModel.title ?? "", isVideo: detailModel.isVideo ?? false, id: Int64(detailModel.id), voteAverage: detailModel.voteAverage, voteCount: Int16(detailModel.voteCount ?? 0), popularity: detailModel.popularity ?? 0, posterPath: detailModel.posterPath ?? "", originalLanguage: detailModel.originalLanguage ?? "", originalTitle: detailModel.originalTitle ?? "", overview: detailModel.overview ?? "", releaseDate: detailModel.releaseDate ?? "", favoritesMovie: true, context: context)
        }
            try? context.save()
    }

}
