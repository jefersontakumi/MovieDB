//
//  Movie.swift
//  MovieDB
//
//  Created by Administrador on 24/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var id: Int
    var vote_count: Int
    var video: Bool
    var vote_average: Double
    var title: String
    var popularity: Double
    var poster_path: String?
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var backdrop_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    
    func posterPath(size: ImageSize) -> String? {
        if let url = poster_path {
            return  "\(Config.apiUrlImg)/\(size)\(url)"
        }
        else
        {
            return nil
        }
    }
    
    func backdropPath(size: ImageSize) -> String? {
        if let url = backdrop_path {
            return  "\(Config.apiUrlImg)/\(size)\(url)"
        }
        else
        {
            return nil
        }
    }
}
