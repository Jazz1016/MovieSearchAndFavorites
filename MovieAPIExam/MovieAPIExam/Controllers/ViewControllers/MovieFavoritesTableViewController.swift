//
//  MovieFavoritesTableViewController.swift
//  MovieAPIExam
//
//  Created by James Lea on 5/7/21.
//

import UIKit

class MovieFavoritesTableViewController: UITableViewController {
    
    // MARK: - Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FavoriteMovieController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print("ViewWillAppear on PokeTeamTableViewController")
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return FavoriteMovieController.shared.favoriteMovieList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieFavoriteCell", for: indexPath) as? FavoriteMovieTableViewCell

        let movie = FavoriteMovieController.shared.favoriteMovieList[indexPath.row]
        
        cell?.movie = movie
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let favoriteMovie = FavoriteMovieController.shared.favoriteMovieList[indexPath.row]
            FavoriteMovieController.shared.deleteFavoriteMovie(movie: favoriteMovie)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
