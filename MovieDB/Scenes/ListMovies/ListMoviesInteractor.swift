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
    func fetchMoviesPoster()
}

protocol ListMoviesDataStore
{
    var moviesUpcoming: [Movie]? { get }
    var moviesPoster: [String:[Movie]]? { get }
}

class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesDataStore
{
    var presenter: ListMoviesPresentationLogic?
    
    var moviesWorker = MovieWorker(movieDBStore: MovieDBAPI())
    var moviesUpcoming: [Movie]?
    var moviesPoster: [String:[Movie]]?
    
    func fetchMovies(request: ListMovies.FetchMovies.Request)
    {
        moviesWorker.fecthMovies(listType: request.listType) { (dataMovies, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let movies = dataMovies
            {
                self.moviesUpcoming = movies
                let response = ListMovies.FetchMovies.Response(movies: movies)
                self.presenter?.presentFetchedMovies(response: response)
            }
        }
    }
    
    func fetchMoviesPoster()
    {
        moviesWorker.fecthMovies(listType: .top_rated) { (dataMovies, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let movies = dataMovies
            {
                if self.moviesPoster == nil {
                    self.moviesPoster = [String:[Movie]]()
                }
                if var aux = self.moviesPoster!["Top_Rated"] {
                    aux.append(contentsOf: movies)
                }
                else
                {
                    self.moviesPoster!["Top_Rated"]  = movies
                }
                let response = ListMovies.FetchMovies.ResponsePoster(movies: self.moviesPoster!)
                self.presenter?.presentFetchedMoviesPoster(response: response)
            }
        }
        
        moviesWorker.fecthMovies(listType: .popular) { (dataMovies, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let movies = dataMovies
            {
                if self.moviesPoster == nil {
                    self.moviesPoster = [String:[Movie]]()
                }
                if var aux = self.moviesPoster!["Popular"] {
                    aux.append(contentsOf: movies)
                }
                else
                {
                    self.moviesPoster!["Popular"]  = movies
                }
                let response = ListMovies.FetchMovies.ResponsePoster(movies: self.moviesPoster!)
                self.presenter?.presentFetchedMoviesPoster(response: response)
            }
        }
    }
}
