//
//  ListMoviesVC.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit
import Foundation

protocol ListMoviesDisplayLogic: class
{
    func displayFetchedMovies(viewModel: [ListMovies.FetchMovies.ViewModel.DisplayedMovie])
    func displayFetchedMoviesPoster(viewModel: [String:[ListMovies.FetchMovies.ViewModel.DisplayedMovie]])
    func displayError(message: String)
}


class ListMoviesVC: UIViewController, ListMoviesDisplayLogic {
    var interactor: ListMoviesBusinessLogic?
    var router: (NSObjectProtocol & ListMoviesRoutingLogic & ListMoviesDataPassing)?
    
    @IBOutlet var upcomingCollection: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    var moviesUpcoming:[ListMovies.FetchMovies.ViewModel.DisplayedMovie]?
    var moviesPoster: [String:[ListMovies.FetchMovies.ViewModel.DisplayedMovie]]?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Setup
    private func setup()
    {
        self.title = "MovieDB"
        
        let btnGenre = UIBarButtonItem.init(title: "Genre", style: .plain, target: self, action: #selector(showGenre))
        self.navigationItem.leftBarButtonItem = btnGenre
        
        let viewController = self
        let interactor = ListMoviesInteractor()
        let presenter = ListMoviesPresenter()
        let router = ListMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovie()
    }
    
    func fetchMovie() {
        interactor?.fetchMovies()
        
        interactor?.fetchMoviesPoster()
    }
    
    func displayFetchedMovies(viewModel: [ListMovies.FetchMovies.ViewModel.DisplayedMovie]) {
        moviesUpcoming = viewModel
        DispatchQueue.main.async {
            self.upcomingCollection.reloadData()
        }
    }
    
    func displayFetchedMoviesPoster(viewModel: [String:[ListMovies.FetchMovies.ViewModel.DisplayedMovie]]) {
        moviesPoster = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayError(message: String) {
        let alert = UIAlertController.init(title: "Erro", message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showGenre() {
        router?.routeToShowGenre(segue: self.storyboard)
    }
}

extension ListMoviesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesUpcoming?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! MovieUpcomingCell
        if let currentMovie = moviesUpcoming?[indexPath.row] {
            cell.titleMovie.text = currentMovie.title
            cell.image.imageFromRemote(urlString: currentMovie.url_image_banner)
        }
        else {
            cell.titleMovie.text = ""
            cell.image.image = #imageLiteral(resourceName: "placeholderImage")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = router?.dataStore?.moviesUpcoming?[indexPath.row]
        router?.routeToShowMovie(segue: self.storyboard, movie: movie!)
    }
    
}

extension ListMoviesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell", for: indexPath) as! PostersCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return moviesPoster != nil && moviesPoster!.count > 0 ? moviesPoster!.count : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
}

extension ListMoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? PostersCell else { return }
        let key = Array(moviesPoster!.keys)[indexPath.section]
        tableViewCell.collectionView.loadConfig(movies: router?.dataStore?.moviesPoster?[key], displayMovies: moviesPoster![key]!, router: router as! ListMoviesRouter, storyboard: self.storyboard!)
        tableViewCell.collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(moviesPoster!.keys)[section]
    }
}
