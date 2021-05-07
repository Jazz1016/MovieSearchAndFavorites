//
//  MoiveListViewController.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieSearchBar.delegate = self
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Properties
    var movieList: [Movie] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            if let index = movieTableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? MovieDetailViewController else {return}
                
                let movieToSend = movieList[index.row]
                
                destinationVC.movie = movieToSend
            }
        }
    }
}

// MARK: Table View

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell
        
        let movie = movieList[indexPath.row]
        
        cell?.movie = movie
        
        
        return cell ?? UITableViewCell()
    }
}


extension MovieListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        MovieController.fetchMovies(title: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movieList = movies
                    self.movieTableView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
}
