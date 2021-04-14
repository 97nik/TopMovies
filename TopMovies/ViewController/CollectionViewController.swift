//
//  CollectionViewController.swift
//  TopMovies
//
//  Created by Никита on 14.04.2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var networkManager = NetworkManager()
    var movies = [Movie]()
    
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson ()
        collectionView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieVC = segue.destination as! ViewController
        let cell = sender as! CollectionViewCell
        guard  let indexPathRow = collectionView.indexPath(for: cell)?.row else { return }
        let selectedMovie = movies[indexPathRow]
        movieVC.movie = selectedMovie
        
    }
    // MARK: - Networking
    private func parseJson (){
        self.networkManager.fetchMovie(forRequestType: .topToday)
        self.networkManager.onResult = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let album):
                    self?.movies = album.results
                    self?.collectionView.reloadData()
                case.failure:
                    self?.presentSearchAlertController()
                }
            }
        }
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! CollectionViewCell
        
        let movie = self.movies[indexPath.row]
        cell.configureCell(movie: movie)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = availableWidth / itemsPerRow + 20
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}
