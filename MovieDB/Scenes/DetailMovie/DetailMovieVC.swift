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
            
            let attributedOptions = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            if let attributedString = try? NSAttributedString(data: movie.title.data(using: .utf8)!, options: attributedOptions, documentAttributes: nil) {
                self.titleMovie.attributedText = attributedString
            }
            else
            {
                self.titleMovie.text = movie.title
            }
            
            self.titleMovie.sizeToFit()
            self.posterImg.imageFromRemote(urlString: movie.url_image_poster)
            self.backdropImg.imageFromRemote(urlString: movie.url_image_backdrop)
            
            self.overview.text = movie.overview
            let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width - 16, height: .greatestFiniteMagnitude)
            let expectedLabelSize = movie.overview?.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], context: nil)
            self.overview.frame = CGRect(x: 8, y: self.overview.frame.origin.y, width: (expectedLabelSize?.size.width)!, height: (expectedLabelSize?.size.height)!)
            self.overview.updateConstraints()
            
            self.videoPlay.isHidden = !movie.hasVideo
            
            self.scroll.contentSize = CGSize(width: self.scroll.frame.size.width, height: self.overview.frame.origin.y + (expectedLabelSize?.size.height)!)
        }
    }
}


