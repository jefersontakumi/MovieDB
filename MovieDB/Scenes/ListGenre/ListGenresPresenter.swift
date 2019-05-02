//
//  ListGenresPresenter.swift
//  MovieDB
//
//  Created by Administrador on 01/05/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

protocol ListGenresPresentationLogic {
    func presentFetchedGenres(response: ListGenres.FetchGenres.Response)
    func showError(message: String)
}

class ListGenresPresenter: ListGenresPresentationLogic
{
    weak var viewController: ListGenresDisplayLogic?
    
    func presentFetchedGenres(response: ListGenres.FetchGenres.Response)
    {
        var displayedGenres: [ListGenres.FetchGenres.ViewModel.DisplayedListGenre] = []
        displayedGenres = response.genres.map { (genre) in
            return ListGenres.FetchGenres.ViewModel.DisplayedListGenre(id: genre.id, name: genre.name)
        }
        viewController?.displayFetchedGenres(viewModel: displayedGenres)
    }
    
    func showError(message: String) {
        viewController?.displayError(message: message)
    }
}
