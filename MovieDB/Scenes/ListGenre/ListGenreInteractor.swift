//
//  ListGenreInteractor.swift
//  MovieDB
//
//  Created by Administrador on 01/05/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

protocol ListGenresBusinessLogic
{
    func fetchGenres()
}

protocol ListGenresDataStore
{
    var genres: [Genre]? { get }
}

class ListGenresInteractor: ListGenresBusinessLogic, ListGenresDataStore
{
    var genres: [Genre]?
    var presenter: ListGenresPresentationLogic?
    
    var moviesWorker = MovieWorker(movieDBStore: MovieDBAPI())
    
    func fetchGenres()
    {
        moviesWorker.fecthGenres { (dataGenres, error) in
            if let errorMessage = error, !errorMessage.isEmpty {
                self.presenter?.showError(message: errorMessage)
            }
            else if let genres = dataGenres
            {
                self.genres = genres
                let response = ListGenres.FetchGenres.Response(genres: genres)
                self.presenter?.presentFetchedGenres(response: response)
            }
        }
    }
}
