//
//  ListGenresModels.swift
//  MovieDB
//
//  Created by Administrador on 01/05/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

enum ListGenres {
    enum FetchGenres {
        struct Request
        {
            
        }
        
        struct Response
        {
            var genres: [Genre]
        }
        
        struct ViewModel {
            struct DisplayedListGenre {
                var id: Int
                var name: String
            }
            
            var displayedGenres: [DisplayedListGenre]
        }
    }
}
