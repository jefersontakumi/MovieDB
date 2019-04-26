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
    var backdrop_path: String
    var adult: Bool
    var overview: String
    var release_date: String
    
    init(id: Int, vote_count: Int, video: Bool, vote_average: Double, title: String, popularity: Double, poster_path: String, original_language: String, original_title: String, genre_ids: [Int], backdrop_path: String, adult: Bool, overview: String, release_date: String) {
        
        self.id = id
        self.vote_count = vote_count
        self.video = video
        self.vote_average = vote_average
        self.title = title
        self.popularity = popularity
        self.poster_path = poster_path
        self.original_language = original_language
        self.original_title = original_title
        self.genre_ids = genre_ids
        self.backdrop_path = backdrop_path
        self.adult = adult
        self.overview = overview
        self.release_date = release_date
    }
    
    func posterPath(size: ImageSize) -> String? {
        if let url = poster_path {
            return  "\(Config.apiUrlImg)/\(size)\(url)"
        }
        else
        {
            return nil
        }
    }
}
