//
//  File.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
