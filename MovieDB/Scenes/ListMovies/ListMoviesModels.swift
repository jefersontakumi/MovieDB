//
//  ListMoviesModels.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

enum ListMovies
{
    enum FetchMovies
    {
        struct Request
        {
            var listType: MovieList
        }
        
        struct Response
        {
            var movies: [Movie]
        }
        
        struct ResponsePoster
        {
            var movies:  [String:[Movie]]
        }
        
        struct ViewModel
        {
            struct DisplayedMovie
            {
                var id: Int
                var title: String
                var url_image_banner: String?
            }
            var displayedMovies: [DisplayedMovie]
            var displayedMoviesPoster:[String:[DisplayedMovie]]
        }
    }
}
