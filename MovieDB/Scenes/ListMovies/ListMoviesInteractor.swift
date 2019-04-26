//
//  ListMoviesInteractor.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

protocol ListMoviesBusinessLogic
{
    func fetchMovies(request: ListMovies.FetchMovies.Request)
}

protocol ListMoviesDataStore
{
    var moviesUpcoming: [Movie]? { get }
    var moviesTopRate: [Movie]? { get }
    var moviesPopular: [Movie]? { get }
}

class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesDataStore
{
    var presenter: ListMoviesPresentationLogic?
    
    var moviesWorker = MovieWorker(movieDBStore: MovieDBAPI())
    var moviesUpcoming: [Movie]?
    var moviesTopRate: [Movie]?
    var moviesPopular: [Movie]?
    
    func fetchMovies(request: ListMovies.FetchMovies.Request)
    {
        moviesWorker.fecthMovies(listType: request.listType) { (dataMovies, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                
            }
            else if let movies = dataMovies
            {
                switch (request.listType) {
                case .upcoming:
                    self.moviesUpcoming? = movies
                case .top_rated:
                    self.moviesTopRate? = movies
                case .popular:
                    self.moviesPopular? = movies
                }
                let response = ListMovies.FetchMovies.Response(movies: movies)
                self.presenter?.presentFetchedMovies(response: response)
            }
        }
    }
}
