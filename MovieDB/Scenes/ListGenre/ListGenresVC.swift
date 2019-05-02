//
//  ListGenreVC.swift
//  MovieDB
//
//  Created by Administrador on 01/05/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

protocol ListGenresDisplayLogic: class
{
    func displayFetchedGenres(viewModel: [ListGenres.FetchGenres.ViewModel.DisplayedListGenre])
    func displayError(message: String)
}

class ListGenresVC: UITableViewController, ListGenresDisplayLogic {

    var interactor: ListGenresBusinessLogic?
    var router: (NSObjectProtocol & ListGenresRoutingLogic & ListGenresDataPassing)?
    
    var genres:  [ListGenres.FetchGenres.ViewModel.DisplayedListGenre]?
    
    var listMovies: ListMoviesVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup()
    {
        self.title = "Genres"
        
        let viewController = self
        let interactor = ListGenresInteractor()
        let presenter = ListGenresPresenter()
        let router = ListGenresRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchGenres()
    }
    
    func fetchGenres() {
        interactor?.fetchGenres()
    }
    
    func displayError(message: String) {
        let alert = UIAlertController.init(title: "Erro", message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayFetchedGenres(viewModel: [ListGenres.FetchGenres.ViewModel.DisplayedListGenre]) {
        self.genres = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return genres?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath)
        cell.accessoryType = .none
        if let genre = genres?[indexPath.row] {
            cell.textLabel?.text = genre.name
            if listMovies?.router?.dataStore?.currentGenreID  == genre.id ||
                listMovies?.router?.dataStore?.currentGenreID == nil && genre.id == 0 {
                cell.accessoryType = .checkmark
            }
        }
        else
        {
            cell.textLabel?.text = ""
        }
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let currentGenre = genres?[indexPath.row] {
            if(currentGenre.id > 0)
            {
                listMovies?.router?.dataStore?.currentGenreID = currentGenre.id
            }
            else
            {
                listMovies?.router?.dataStore?.currentGenreID = nil
            }
            navigationController?.popViewController(animated: true)
        }
    }

}
