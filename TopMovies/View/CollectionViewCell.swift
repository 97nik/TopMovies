//
//  CollectionViewCell.swift
//  TopMovies
//
//  Created by Никита on 14.04.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func configureCell(movie: Movie) {
        nameLabel.text = movie.title
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.posterImageView?.image = UIImage(data: imageData)
            }
        }
    }
}



