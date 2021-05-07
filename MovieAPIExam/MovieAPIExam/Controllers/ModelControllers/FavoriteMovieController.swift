//
//  FavoriteMovieController.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import Foundation

class FavoriteMovieController {
    
    static let shared = FavoriteMovieController()
    
    var favoriteMovieList: [FavoriteMovie] = []
    
    func addFavoriteMovie(title: String, overview: String, vote_average: Double, poster_path: String){
        let newMovie = FavoriteMovie(title: title, overview: overview, vote_average: vote_average, poster_path: poster_path)
        favoriteMovieList.append(newMovie)
        
        saveToPersistentStore()
    }
    
    func deleteFavoriteMovie(movie: FavoriteMovie){
        guard let movieIndex = favoriteMovieList.firstIndex(of: movie) else {return}
        favoriteMovieList.remove(at: movieIndex)
        
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    func createPersistentStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("MovieAPIExam.json")
        return fileURL
    }
    
    func saveToPersistentStore() {
        do {
            let data = try JSONEncoder().encode(favoriteMovieList)
            try data.write(to: createPersistentStore())
        } catch {
            print("ERROR ENCODING SONGS")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: createPersistentStore())
            favoriteMovieList = try JSONDecoder().decode([FavoriteMovie].self, from: data)
        } catch {
            print("ERROR LOADING SONGS")
        }
    }
}//End of class
