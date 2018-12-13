//
//  File.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import Foundation

struct UpcomingMovie {
    let voteCount: Int?
    let id: Int
    let isVideo: Bool?
    let voteAverage: Double
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let genreIDs: [Int]?
    let backdropPath: String?
    let isAdultContent: Bool?
    let overview: String?
    let releaseDate: String?
}

extension UpcomingMovie: Decodable {
    enum Keys: String, CodingKey {
        case voteCount = "vote_count"
        case id = "id"
        case isVideo = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case isAdultContent = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let voteCount: Int? = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        let id: Int = try container.decode(Int?.self, forKey: .id) ?? 0
        let isVideo: Bool? = try container.decodeIfPresent(Bool.self, forKey: .isVideo)
        let voteAverage: Double = try container.decode(Double.self, forKey: .voteAverage)
        let title: String? = try container.decodeIfPresent(String.self, forKey: .title)
        let popularity: Double? = try container.decodeIfPresent(Double.self, forKey: .popularity)
        let posterPath: String? = try container.decodeIfPresent(String.self, forKey: .posterPath)
        let originalLanguage: String? = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        let originalTitle: String? = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        let genreIDs: [Int]? = try container.decodeIfPresent([Int].self, forKey: .genreIDs)
        let backdropPath: String? = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        let isAdultContent: Bool? = try container.decodeIfPresent(Bool.self, forKey: .isAdultContent)
        let overview: String? = try container.decodeIfPresent(String.self, forKey: .overview)
        let releaseDate: String? = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.init(voteCount: voteCount,id: id, isVideo: isVideo, voteAverage: voteAverage, title: title, popularity: popularity, posterPath: posterPath, originalLanguage: originalLanguage, originalTitle: originalTitle, genreIDs: genreIDs, backdropPath: backdropPath, isAdultContent: isAdultContent, overview: overview, releaseDate: releaseDate)
    }
}
