//
//  DetailMovieInteractor.swift
//  MovieDB
//
//  Created by Administrador on 28/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

protocol DetailMovieBusinessLogic
{
    
}

protocol DetailMovieDataStore
{
    var movie: Movie? { get set }
}

class DetailMovieInteractor: DetailMovieBusinessLogic, DetailMovieDataStore {
    var movie: Movie?
}
