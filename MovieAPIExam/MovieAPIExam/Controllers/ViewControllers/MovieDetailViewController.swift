//
//  MovieDetailViewController.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    @IBOutlet weak var movieVoteNumberLabel: UILabel!
    
    @IBOutlet weak var moviePopularityLabel: UILabel!
    
    @IBOutlet weak var movieBackdropImage: UIImageView!
    
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Properties
    var movie: Movie?
    
    // MARK: - Functions
    func updateView(){
        guard let movie = movie else {return}
        
        self.movieTitle.text = movie.title
        self.movieReleaseDate.text = movie.release_date
        self.movieRatingLabel.text = "\(movie.vote_average)"
        self.movieVoteNumberLabel.text = "\(movie.vote_count)"
        self.moviePopularityLabel.text = "\(movie.popularity)"
        self.movieDescriptionLabel.text = movie.overview
        
        MovieController.fetchMovieImage(imagePath: movie.poster_path) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let image):
                    self.moviePosterImage.image = image
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
        MovieController.fetchMovieImage(imagePath: movie.backdrop_path ?? "") { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.movieBackdropImage.image = image
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
