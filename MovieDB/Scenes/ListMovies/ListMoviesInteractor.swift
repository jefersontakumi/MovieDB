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
    func fetchMovies()
    func fetchMoviesPoster()
}

protocol ListMoviesDataStore
{
    var currentGenreID: Int?  {get set}
    var moviesUpcoming: [Movie]? { get }
    var moviesPoster: [String:[Movie]]? { get }
}

class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesDataStore
{
    var presenter: ListMoviesPresentationLogic?
    
    var moviesWorker = MovieWorker(movieDBStore: MovieDBAPI())
    var currentGenreID: Int?
    var moviesUpcoming: [Movie]?
    var moviesPoster: [String:[Movie]]?
    
    func fetchMoviesByGenre(id: Int?, listType: MovieList?)
    {
        moviesWorker.fecthMovies(genreID: id, listType: listType) { (dataMovies, error) in
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
    
    func fetchMovies()
    {
        var currentGenre: Int? = nil
        if let genre = currentGenreID, genre > 0 {
            currentGenre = genre
        }
        
        moviesWorker.fecthMovies(genreID: currentGenre, listType: nil) { (dataMovies, error) in
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
        let loadMovies = DispatchGroup()
        
        var currentGenre: Int? = nil
        if let genre = currentGenreID, genre > 0 {
            currentGenre = genre
        }
        
        loadMovies.enter()
        moviesWorker.fecthMovies(genreID: currentGenre, listType: .new) { (dataMovies, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let movies = dataMovies
            {
                if self.moviesPoster == nil {
                    self.moviesPoster = [String:[Movie]]()
                }
                self.moviesPoster!["New"]  = movies
                loadMovies.leave()
            }
        }
        
        loadMovies.enter()
        moviesWorker.fecthMovies(genreID: currentGenre, listType: .top_rated) { (dataMovies, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let movies = dataMovies
            {
                if self.moviesPoster == nil {
                    self.moviesPoster = [String:[Movie]]()
                }
                self.moviesPoster!["Top Rated"]  = movies
               loadMovies.leave()
            }
        }
        
        loadMovies.enter()
        moviesWorker.fecthMovies(genreID: currentGenre, listType: .popular) { (dataMovies, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let movies = dataMovies
            {
                if self.moviesPoster == nil {
                    self.moviesPoster = [String:[Movie]]()
                }
                self.moviesPoster!["Popular"]  = movies
                loadMovies.leave()
            }
        }
        
        loadMovies.notify(queue: .main) {
            let response = ListMovies.FetchMovies.ResponsePoster(movies: self.moviesPoster!)
            self.presenter?.presentFetchedMoviesPoster(response: response)
        }
    }
}
