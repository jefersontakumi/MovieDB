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
    
    func requestGet(requestURLString: String, parameters: Dictionary<String, Any>, callback: @escaping (Result<MovieDBError>)-> Void) {
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
    
    func fetchMovies(genreID: Int?, listType: MovieList?, done: @escaping ([Movie]) -> Void, fail: @escaping (String) -> Void){
        let requestURLString = "\(Config.apiUrl)/discover/movie"
        var parameters: Dictionary<String, Any> = [
            "api_key": Config.apiKey
        ]
        
        if let genre = genreID {
            parameters["with_genres"] = "\(genre)"
        }
        
        if let movieType = listType {
            switch movieType {
            case .new:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let today = dateFormatter.string(from: Date())
                let thirtyDaysInSeconds: TimeInterval = 60 * 60 * 24 * 30
                let thirtyDaysAgo = dateFormatter.string(from: Date(timeIntervalSinceNow: -thirtyDaysInSeconds))
                
                parameters["sort_by"] = "primary_release_date.desc"
                parameters["page"] = 1
                parameters["primary_release_date.gte"] = thirtyDaysAgo
                parameters["primary_release_date.lte"] = today
            case .popular:
                parameters["sort_by"] = "popularity.desc"
                parameters["page"] = 1
            case .top_rated:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy"
                let year = dateFormatter.string(from: Date())
                
                parameters["sort_by"] = "vote_average.desc"
                parameters["page"] = 1
                parameters["vote_count.gte"] = 1
                parameters["primary_release_year"] = Int(year)
            }
        }
        
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
            "api_key": Config.apiKey
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
    
    func getMovie(id: Int, done: @escaping (DetailMovie) -> Void, fail: @escaping (String) -> Void){
        let requestURLString = "\(Config.apiUrl)/movie/\(id)"
        var parameters: Dictionary<String, String> = [
            "api_key": Config.apiKey
        ]
        
        parameters["append_to_response"] = "videos"
        
        var movie: DetailMovie?
        
        self.requestGet(requestURLString: requestURLString, parameters: parameters){ (result) in
            switch result {
            case .success(let data):
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDictionary = jsonObject as? [String: Any] {
                    movie = try! JSONDecoder().decode(DetailMovie.self, from: try! JSONSerialization.data(withJSONObject: jsonDictionary, options: JSONSerialization.WritingOptions.prettyPrinted))
                    done(movie!)
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
    
    func fetchGenres(done: @escaping ([Genre]) -> Void, fail: @escaping (String) -> Void){
        let requestURLString = "\(Config.apiUrl)/genre/movie/list"
        let parameters: Dictionary<String, String> = [
            "api_key": Config.apiKey
        ]
        
        var genres :[Genre] = []
        
        self.requestGet(requestURLString: requestURLString, parameters: parameters){ (result) in
            switch result {
            case .success(let data):
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                    let jsonDictionary = jsonObject as? [String: Any],
                    let results = jsonDictionary["genres"] {
                    genres = try! JSONDecoder().decode([Genre].self, from: try! JSONSerialization.data(withJSONObject: results, options: JSONSerialization.WritingOptions.prettyPrinted))
                    done(genres)
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
