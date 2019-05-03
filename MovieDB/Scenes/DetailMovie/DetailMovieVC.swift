//
//  DetailMovieVC.swift
//  MovieDB
//
//  Created by Administrador on 28/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

protocol DetailMovieDisplayLogic: class
{
    func displayError(message: String)
    func displayFetchedMovie(viewModel: DetailMovieModels.GetMovie.ViewModel)
}

class DetailMovieVC: UIViewController, DetailMovieDisplayLogic {

    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var backdropImg: UIImageView!
    @IBOutlet var posterImg: UIImageView!
    @IBOutlet var titleMovie: UILabel!
    @IBOutlet var releaseYear: UILabel!
    @IBOutlet var overview: UILabel!
    @IBOutlet var videoPlay: UIButton!
    
    var interactor: DetailMovieBusinessLogic?
    var router: (NSObjectProtocol & DetailMovieRoutingLogic & DetailMovieDataPassing)?
    
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
        interactor?.getMovie(request: DetailMovieModels.GetMovie.Request(id: (router?.dataStore?.movie!.id)!))
    }
    
    private func setup()
    {
        let viewController = self
        let interactor = DetailMovieInteractor()
        let presenter = DetailMoviePresenter()
        let router = DetailMovieRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func displayError(message: String) {
        let alert = UIAlertController.init(title: "Erro", message: message, preferredStyle: .alert)
        let btnOk = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayFetchedMovie(viewModel: DetailMovieModels.GetMovie.ViewModel) {
        DispatchQueue.main.async {
            let movie = viewModel.displayedDetailMovie
            self.titleMovie.text = movie.title
            self.titleMovie.sizeToFit()
            self.posterImg.imageFromRemote(urlString: movie.url_image_poster)
            self.backdropImg.imageFromRemote(urlString: movie.url_image_backdrop)
            
            self.overview.text = movie.overview
            self.overview.sizeToFit()
            self.releaseYear.text = "\(movie.release_year)"
            
            self.videoPlay.isHidden = !movie.video
        }
    }
}


