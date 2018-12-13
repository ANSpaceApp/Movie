//
//  File.swift
//  MovieApp
//
//  Created by Амир Разаков on 12.12.2018.
//  Copyright © 2018 Амир Разаков. All rights reserved.
//

import Foundation

class DataProvider {
    static func fetchData(url: String, completion: @escaping (_ courses: [UpcomingMovie])->()) {
        guard let url = URL(string: url) else { return }
         URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
             do {
        let courses = try JSONDecoder().decode(MovieResult.self, from: data)
                print(courses)
                let outerResponse = NSMutableArray()
                for values in courses.results! {
                    outerResponse.add(values)
                }
                completion(outerResponse as! [UpcomingMovie])
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
}
