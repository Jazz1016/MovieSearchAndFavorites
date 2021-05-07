//
//  MovieTableViewCell.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescLabel: UILabel!
    @IBOutlet weak var movieFavoritesButton: UIButton!
    
    
    
    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            updateViews()
        }
    }
    
    
    // MARK: - Functions
    func updateViews(){
        
        guard let movie = movie else {return}
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.vote_average)/10"
        movieDescLabel.text = movie.overview
        
        MovieController.fetchMovieImage(imagePath: movie.poster_path) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.movieImage.image = image
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    @IBAction func movieFavoritesButtonTapped(_ sender: Any) {
        
        guard let movie = movie else {return}
        
        FavoriteMovieController.shared.addFavoriteMovie(title: movie.title, overview: movie.overview, vote_average: movie.vote_average, poster_path: movie.poster_path)
        
    }
    
}
