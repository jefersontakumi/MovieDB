//
//  MovieDBWorker.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

protocol MovieWorkerProtocol {
    func fecthMovies(genreID: Int?, completionHandler: @escaping ([Movie]?, String?) -> Void) 
    func fecthMovies(listType: MovieList,completionHandler: @escaping ([Movie]?, String?) -> Void)
    func getMovie(id: Int, completionHandler: @escaping (DetailMovie?, String?) -> Void)
    func fecthGenres(completionHandler: @escaping ([Genre]?, String?) -> Void)
}

class MovieWorker: MovieWorkerProtocol {
    var movieDBStore: MovieDBStoreProtocol
    
    init(movieDBStore: MovieDBStoreProtocol) {
        self.movieDBStore = movieDBStore
    }
    
    func fecthMovies(genreID: Int?, completionHandler: @escaping ([Movie]?, String?) -> Void) {
        movieDBStore.fetchMovies(genreID: genreID, done: { (data) in
            DispatchQueue.main.async {
                completionHandler(data, nil)
            }
        }, fail: { (error) in
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
        })
    }
    
    func fecthMovies(listType: MovieList, completionHandler: @escaping ([Movie]?, String?) -> Void) {
        movieDBStore.fetchMovies(listType: listType, done: { (data) in
            DispatchQueue.main.async {
                completionHandler(data, nil)
            }
        }, fail: { (error) in
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
        })
    }
    
    func getMovie(id: Int, completionHandler: @escaping (DetailMovie?, String?) -> Void) {
        movieDBStore.getMovie(id: id, done: { (data) in
            DispatchQueue.main.async {
                completionHandler(data, nil)
            }
        }, fail: { (error) in
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
        })
    }
    
    func fecthGenres(completionHandler: @escaping ([Genre]?, String?) -> Void) {
        movieDBStore.fetchGenres(done: { (data) in
            DispatchQueue.main.async {
                completionHandler(data, nil)
            }
        }, fail: { (error) in
            DispatchQueue.main.async {
                completionHandler(nil, error)
            }
        })
    }
}
