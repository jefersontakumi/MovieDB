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
    
}

class DetailMovieVC: UIViewController, DetailMovieDisplayLogic {

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
        super.viewDidLoad()    }
    
    private func setup()
    {
        let viewController = self
        let interactor = DetailMovieInteractor()
        let router = DetailMovieRouter()
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
    }

}
