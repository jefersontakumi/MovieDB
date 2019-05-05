//
//  DetailMovieModels.swift
//  MovieDB
//
//  Created by Administrador on 30/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

enum DetailMovieModels
{
    enum GetMovie
    {
        struct Request
        {
            var id: Int
        }
        
        struct Response
        {
            var movie: DetailMovie
        }
        
        struct ViewModel
        {
            struct DisplayedDetailMovie
            {
                var title: String
                var url_image_backdrop: String?
                var url_image_poster: String?
                var overview: String?
                var release_year: Int
                var video: Bool
                var hasVideo: Bool
            }
            var displayedDetailMovie: DisplayedDetailMovie
        }
    }
}
