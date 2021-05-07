//
//  Movie.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import Foundation


struct TopLevelObject: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let overview: String
    let vote_average: Double
    let vote_count: Int
    let poster_path: String
    let backdrop_path: String?
    let release_date: String
    let popularity: Double
}
