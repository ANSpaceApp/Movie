//
//  FavoritesBuilder.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import Foundation
import CoreData

extension FavoritesMO {
    static func fetchedCoins(inContext context: NSManagedObjectContext)-> [FavoritesMO] {
        let fr = NSFetchRequest<FavoritesMO>(entityName: "Favorites")
        fr.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        do {
            let fetchResults = try context.fetch(fr)
            return fetchResults
        }catch{
            print("Ошибка поиска - \(error)")
            return [FavoritesMO]()
        }
    }
    
    
    //MARK: - Create or Update
    static func createOrUpdate(title: String,
                              isVideo: Bool,
                               id: Int64,
                               voteAverage: Double,
                               voteCount: Int16,
                               popularity: Double,
                               posterPath: String,
                               originalLanguage: String,
                               originalTitle: String,
                               overview: String,
                               releaseDate: String,
                               favoritesMovie: Bool,
                               context: NSManagedObjectContext)-> FavoritesMO? {
        let fr = NSFetchRequest<FavoritesMO>(entityName: "Favorites")
        fr.predicate = NSPredicate(format: "id=%d", id)
        fr.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        do {
            let fetchResults = try context.fetch(fr)
            if fetchResults.count == 0 {
                //print("create")
                let favorites = FavoritesMO(context: context)
                favorites.id = id
                favorites.title = title
                favorites.favoritesMovie = favoritesMovie
                favorites.isVideo = isVideo
                favorites.originalLanguage = originalLanguage
                favorites.originalTitle = originalTitle
                favorites.overview = overview
                favorites.populary = popularity
                favorites.posterPath = posterPath
                favorites.releaseDate = releaseDate
                return favorites
            }else {
                //print("update")
                let favorites = fetchResults[0]
                favorites.isVideo = isVideo
                favorites.title = title
                favorites.favoritesMovie = favoritesMovie
                favorites.originalLanguage = originalLanguage
                favorites.originalTitle = originalTitle
                favorites.overview = overview
                favorites.populary = popularity
                favorites.posterPath = posterPath
                favorites.releaseDate = releaseDate
                return favorites
            }
        }catch{
            print("Ошибка поиска - \(error)")
            return nil
        }
    }

    static func fetchResultsController(context: NSManagedObjectContext)-> NSFetchedResultsController<FavoritesMO> {
        let fr = NSFetchRequest<FavoritesMO>(entityName: "Favorites")
        fr.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        // print("Контекст инициализации - \(context)")
        return NSFetchedResultsController<FavoritesMO>(fetchRequest: fr,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
    }
}
