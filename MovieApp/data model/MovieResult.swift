//
//  File.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import Foundation

struct MovieResult: Decodable {
    let results: [UpcomingMovie]?
    let total_pages: Int
}
