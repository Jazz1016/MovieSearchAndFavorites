//
//  FavoriteMovieTableViewCell.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var moviePostImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    
    // MARK: - Properties
    var movie: FavoriteMovie? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func movieDeleteTapped(_ sender: Any) {
        
        guard let movie = movie else {return}
        
        FavoriteMovieController.shared.deleteFavoriteMovie(movie: movie)
    }
    
    
    // MARK: - Functions
    func updateView() {
        guard let movie = movie else {return}
        
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.vote_average)"
        movieDescriptionLabel.text = movie.overview
        
        
        MovieController.fetchMovieImage(imagePath: movie.poster_path) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.moviePostImage.image = image
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
