//
//  MovieListTableViewController.swift
//  MovieList
//
//  Created by Jason Mandozzi on 6/28/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    
    var movieItems: [Movie] = []
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieController.fetchMovieItem(apiKey: "18abaabe4391bdf77d1c6ee1a79a24dc", searchQuery: "Fight Club") { (movies) in
            if let unwrappedMovieItem = movies {
                self.movieItems = unwrappedMovieItem
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return movieItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let movieItem = movieItems[indexPath.row]
        
        cell.movieTitleLabel.text = movieItem.title
        cell.movieRatingLabel.text = movieItem.rating
        cell.movieDescriptionLabel.text = movieItem.description
        
        MovieController.fetchImageFor(movie: movieItem) { (image) in
            DispatchQueue.main.async {
                cell.movieImageView.image = image
            }
        }
        

        return cell
    }
}

extension MovieListTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, searchTerm != "" else {return}
        
        MovieController.fetchMovieItem(apiKey: "18abaabe4391bdf77d1c6ee1a79a24dc", searchQuery: searchTerm) { (movieItemsFromCompletion) in
            if let unwrappedMovieItems = movieItemsFromCompletion {
                self.movieItems = unwrappedMovieItems
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}
