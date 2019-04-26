//
//  MovieDBWorker.swift
//  MovieDB
//
//  Created by Administrador on 25/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation

protocol MovieWorkerProtocol {
    func fecthMovies(listType: MovieList,completionHandler: @escaping ([Movie]?, String?) -> Void)
}

class MovieWorker: MovieWorkerProtocol {
    var movieDBStore: MovieDBStoreProtocol
    
    init(movieDBStore: MovieDBStoreProtocol) {
        self.movieDBStore = movieDBStore
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
}
