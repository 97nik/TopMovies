//
//  TableViewController.swift
//  TopMovies
//
//  Created by Никита on 13.04.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var networkManager = NetworkManager()
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieVC = segue.destination as! ViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let selectedMovie = movies[indexPath.row]
        movieVC.movie = selectedMovie
        
    }
    
    // MARK: - Networking
    private func parseJson (){
        self.networkManager.fetchMovie(forRequestType: .topOld)
        self.networkManager.onResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let album):
                    self?.movies = album.results
                    self?.tableView.reloadData()
                case.failure:
                    self?.presentSearchAlertController()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieIndeficator", for: indexPath) as! TableViewCell
        
        let movie = self.movies[indexPath.row]
        cell.configureCell(movie: movie)
        
        return cell
    }
    
}

