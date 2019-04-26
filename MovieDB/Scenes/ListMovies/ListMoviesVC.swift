//
//  ListMoviesVC.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

protocol ListMoviesDisplayLogic: class
{
    func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel)
}


class ListMoviesVC: UIViewController, ListMoviesDisplayLogic {
    var interactor: ListMoviesBusinessLogic?
    var router: (NSObjectProtocol & ListMoviesRoutingLogic & ListMoviesDataPassing)?
    
    @IBOutlet var upcomingCollection: UICollectionView!
    
    var moviesUpcoming:[ListMovies.FetchMovies.ViewModel.DisplayedMovie]?
    
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
        let requestMovie = ListMovies.FetchMovies.Request(listType: .upcoming)
        interactor?.fetchMovies(request: requestMovie)
    }
    
    func displayFetchedMovies(viewModel: ListMovies.FetchMovies.ViewModel) {
        moviesUpcoming = viewModel.displayedMovies
        upcomingCollection.reloadData()
    }
}

extension ListMoviesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 1)
        {
            return moviesUpcoming?.count ?? 0
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! MovieUpcomingCell
        let currentMovie = moviesUpcoming![indexPath.row]
        cell.setImage(urlImage: currentMovie.url_image_banner)
        return cell
    }
}
