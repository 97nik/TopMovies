//
//  ViewController.swift
//  TopMovies
//
//  Created by Никита on 13.04.2021.
//

import UIKit
import EventKit
import EventKitUI

class ViewController: UIViewController, EKEventEditViewDelegate {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoMovieLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var movie: Movie?
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    let eventStore = EKEventStore()
    var time = Date()
    
    @IBAction func scheduleViewingButtom(_ sender: Any) {
        eventStore.requestAccess( to: EKEntityType.event, completion:{(granted, error) in
            DispatchQueue.main.async {
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: self.eventStore)
                    event.title = self.movie?.title
                    event.startDate = self.time
                    event.notes = self.movie?.overview
                    event.endDate = self.time
                    
                    let eventController = EKEventEditViewController()
                    eventController.event = event
                    eventController.eventStore = self.eventStore
                    eventController.editViewDelegate = self
                    self.present(eventController, animated: true, completion: nil)
                }
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rateLabel.layer.masksToBounds = true
        rateLabel.layer.cornerRadius = 15
        guard let voteAverage = movie?.voteAverage else { return }
        choiceColor(voteAverage: voteAverage)
        
        if let movie = movie {
            nameLabel.text = movie.title
            rateLabel.text = String(movie.voteAverage)
            dateLabel.text = movie.releaseDate
            
            if movie.overview.isEmpty {
                infoMovieLabel.text = "Описание отсутствует"
            } else {
                infoMovieLabel.text = movie.overview
            }
            
            DispatchQueue.global().async {
                guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") else { return }
                guard let imageData = try? Data(contentsOf: imageUrl) else { return }
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func choiceColor (voteAverage: Double){
        switch voteAverage {
        case ..<5:
            rateLabel.backgroundColor = UIColor.red
        case ..<7:
            rateLabel.backgroundColor = UIColor.gray
        default :
            rateLabel.backgroundColor = UIColor.green
        }
    }
}
