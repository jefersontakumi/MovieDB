//
//  MoviesCollectionView.swift
//  MovieDB
//
//  Created by Administrador on 26/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

class MoviesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var movies: [Movie]?
    var displayMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie]?
    var router: ListMoviesRouter?
    var storyboard: UIStoryboard?
    
    func loadConfig(movies:[Movie]?, displayMovies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie], router: ListMoviesRouter, storyboard: UIStoryboard) {
        self.delegate = self
        self.dataSource = self
        self.displayMovies = displayMovies
        self.movies = movies
        self.router = router
        self.storyboard = storyboard
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterMovieCell
        let currentMovie = displayMovies![indexPath.row]
        collectionCell.image.imageFromRemote(urlString: currentMovie.url_image_banner)
        let attributedOptions = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        if let attributedString = try? NSAttributedString(data: currentMovie.title.data(using: .utf8)!, options: attributedOptions, documentAttributes: nil) {
            collectionCell.title.attributedText = attributedString
        }
        else
        {
            collectionCell.title.text = currentMovie.title
        }
        collectionCell.title.sizeToFit()
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movies?[indexPath.row] {
            router?.routeToShowMovie(segue: self.storyboard, movie: movie)
        }
    }
}
