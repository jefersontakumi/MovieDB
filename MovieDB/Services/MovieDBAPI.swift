//
//  MovieDBAPI.swift
//  MovieDB
//
//  Created by Administrador on 24/04/19.
//  Copyright © 2019 JHT. All rights reserved.
//

import Foundation
import Alamofire

class MovieDBAPI: MovieDBStoreProtocol {
    
    func requestGet(requestURLString: String, parameters: Dictionary<String, String>, callback: @escaping (Result<MovieDBError>)-> Void) {
        Alamofire.request(requestURLString, method: .get, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        callback(.success(data: data))
                    }
                case .failure:
                    callback(.failed(MovieDBError.badRequest("Ocorreu um problema na requisição")))
                }
        }
    }
    
    func fetchMovies( done: @escaping ([Movie]) -> Void, fail: @escaping (String) -> Void){
        let requestURLString = "\(Config.apiUrl)/discover/movie"
        let parameters: Dictionary<String, String> = [
            "api_key": Config.apiKey,
            "sort_by": "popularity.desc"
        ]
        
        var movies :[Movie] = []
        
        self.requestGet(requestURLString: requestURLString, parameters: parameters){ (result) in
            switch result {
            case .success(let data):
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDictionary = jsonObject as? [String: Any],
                    let results = jsonDictionary["results"] {
                    movies = try! JSONDecoder().decode([Movie].self, from: try! JSONSerialization.data(withJSONObject: results, options: JSONSerialization.WritingOptions.prettyPrinted))
                    done(movies)
                }
                else
                {
                    fail("Ocorreu um problema na conversão")
                }
            case .failed(let error):
                fail(error.localizedDescription)
            }
        }
    }
    
    func fetchMovies(listType: MovieList, done: @escaping ([Movie]) -> Void, fail: @escaping (String) -> Void){
        let requestURLString = "\(Config.apiUrl)/movie/\(listType)"
        let parameters: Dictionary<String, String> = [
            "api_key": Config.apiKey,
            "sort_by": "popularity.desc"
        ]
        
        var movies :[Movie] = []
        
        self.requestGet(requestURLString: requestURLString, parameters: parameters){ (result) in
            switch result {
            case .success(let data):
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDictionary = jsonObject as? [String: Any],
                    let results = jsonDictionary["results"] {
                    movies = try! JSONDecoder().decode([Movie].self, from: try! JSONSerialization.data(withJSONObject: results, options: JSONSerialization.WritingOptions.prettyPrinted))
                    done(movies)
                }
                else
                {
                    fail("Ocorreu um problema na conversão")
                }
            case .failed(let error):
                fail(error.localizedDescription)
            }
        }
    }
}
