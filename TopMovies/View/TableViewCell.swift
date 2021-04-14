//
//  TableViewCell.swift
//  TopMovies
//
//  Created by Никита on 13.04.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Styles
        shadowView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        shadowView.layer.shadowRadius = 1.5
        shadowView.layer.shadowOpacity = 0.2
        shadowView.layer.cornerRadius = 2
        
        movieImageView.layer.cornerRadius = 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(movie: Movie) {
        self.nameLabel.text = movie.title
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.movieImageView?.image = UIImage(data: imageData)
            }
        }
    }
    
}
