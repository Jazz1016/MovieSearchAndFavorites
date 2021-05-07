//
//  MovieController.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

//https://api.themoviedb.org/3/search/movie?api_key=0eaba5e7444cad9e4d9add5589640586&language=en-US&query=It&page=1&include_adult=false

import UIKit

class MovieController {
    
    static func fetchMovies(title: String, completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        
        let baseURL = "https://api.themoviedb.org/3/search/movie?api_key=\(Strings.apiToken)&language=en-US&query=It&page=1&include_adult=false"
        var components = URLComponents(string: baseURL)
        let apiQuery = URLQueryItem(name: "api_key", value: Strings.apiToken)
        let movieQuery = URLQueryItem(name: "query", value: title)
        
        components?.queryItems = [apiQuery, movieQuery]
        
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("MOVE LIST STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let movies = topLevelObject.results
                
                completion(.success(movies))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchMovieImage(imagePath: String, completion: @escaping (Result<UIImage, MovieError>) -> Void) {
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")
        
        guard let url = url else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                return completion(.failure(.thrownError(error)))
                
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let poster = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            
            completion(.success(poster))
        }.resume()
    }
}
