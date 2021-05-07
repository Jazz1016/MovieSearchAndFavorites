//
//  FavoriteMovie.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import Foundation

class FavoriteMovie: Codable {
    
    let title: String
    let overview: String
    let vote_average: Double
    let poster_path: String
    
    init(title: String, overview: String, vote_average: Double, poster_path: String){
        
        self.title = title
        self.overview = overview
        self.vote_average = vote_average
        self.poster_path = poster_path
    }
}


// MARK: - Extensions
extension FavoriteMovie: Equatable {
    static func == (lhs: FavoriteMovie, rhs: FavoriteMovie) -> Bool {
        return lhs.title == rhs.title && lhs.overview == rhs.overview && lhs.vote_average == rhs.vote_average
    }
}
