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
    func getMovie(request: DetailMovieModels.GetMovie.Request)
}

protocol DetailMovieDataStore
{
    var movie: Movie? { get set }
}

class DetailMovieInteractor: DetailMovieBusinessLogic, DetailMovieDataStore {
    var movie: Movie?
    
    var presenter: DetailMoviePresentationLogic?
    var moviesWorker = MovieWorker(movieDBStore: MovieDBAPI())
    
    func getMovie(request: DetailMovieModels.GetMovie.Request)
    {
        moviesWorker.getMovie(id: request.id) { (dataMovie, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let currentMovie = dataMovie
            {
                let response = DetailMovieModels.GetMovie.Response(movie: currentMovie)
                self.presenter?.presentFetchedDetailMovie(response: response)
            }
        }
    }
}



