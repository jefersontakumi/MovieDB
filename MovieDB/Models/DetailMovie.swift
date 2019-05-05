//
//  DetailMovie.swift
//  MovieDB
//
//  Created by Administrador on 30/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

struct DetailMovie: Codable {
    var adult: Bool
    var backdrop_path: String?
    var budget: Double
    var genres: [Genre]
    var homepage: String?
    var id: Int
    var imdb_id: String?
    var original_language: String
    var original_title: String
    var overview: String?
    var popularity: Double
    var poster_path: String?
    var production_companies: [Company]
    var production_countries: [Country]
    var release_date: String
    var revenue: Int = 0
    var runtime: Int?
    var spoken_languages: [Language]
    //var status: MovieStatus
    var tagline: String?
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
    var videos: VideoResult
    
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
