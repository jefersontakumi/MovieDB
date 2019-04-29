//
//  MoviesCollectionView.swift
//  MovieDB
//
//  Created by Administrador on 26/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import UIKit

class MoviesCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var movies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie]?
    var router: ListMoviesRouter?
    var storyboard: UIStoryboard?
    
    func loadConfig(movies: [ListMovies.FetchMovies.ViewModel.DisplayedMovie], router: ListMoviesRouter, storyboard: UIStoryboard) {
        self.delegate = self
        self.dataSource = self
        self.movies = movies
        self.router = router
        self.storyboard = storyboard
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "posterCell", for: indexPath) as! PosterMovieCell
        let currentMovie = movies![indexPath.row]
        collectionCell.setImage(urlImage: currentMovie.url_image_banner?.replacingOccurrences(of: "w500_and_h282_face", with: "w185"))
        collectionCell.title.text = currentMovie.title
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = router?.dataStore?.moviesUpcoming?[indexPath.row]
        router?.routeToShowMovie(segue: self.storyboard, movie: movie!)
    }
}