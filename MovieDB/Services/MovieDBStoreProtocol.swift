//
//  MovieDBStoreProtocol.swift
//  MovieDB
//
//  Created by Administrador on 24/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

protocol MovieDBStoreProtocol {
    func fetchMovies(done: @escaping ([Movie]) -> Void, fail: @escaping (String) -> Void)
    func fetchMovies(listType: MovieList, done: @escaping ([Movie]) -> Void, fail: @escaping (String) -> Void)
    func getMovie(id: Int, done: @escaping (DetailMovie) -> Void, fail: @escaping (String) -> Void)
}
