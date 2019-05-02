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
        if let genre = genres?[indexPath.row] {
            cell.textLabel?.text = genre.name
        }
        else
        {
            cell.textLabel?.text = ""
        }
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
