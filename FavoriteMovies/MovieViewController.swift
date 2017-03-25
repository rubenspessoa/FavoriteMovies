//
//  MovieViewController.swift
//  FavoriteMovies
//
//  Created by Rubens Pessoa on 23/03/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var plotText: UITextView!
    
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var awardsLabel: UILabel!
    
    @IBOutlet weak var actorsLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    var imageUrlString: String?
    var imageUrl: URL?
    
    let movieDAO: MovieDAO = MovieDAO()
    var movie: Movie? = nil
    var movieImdbID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDAO.getMovie(byImdbID: self.movieImdbID!, completionHandler: {
            movieResult in
            
            self.movie = movieResult
            
            self.title = self.movie!.Title
            self.ratingLabel.text = self.movie?.imdbRating
            self.yearLabel.text = self.movie!.Year
            self.genreLabel.text = self.movie!.Genre
            self.plotText.text = self.movie!.Plot
            self.imageUrlString = self.movie!.Poster
            self.imageUrl = URL(string: self.imageUrlString!)
            self.directorLabel.text = self.movie!.Director
            self.awardsLabel.text = self.movie?.Awards
            self.actorsLabel.text = self.movie!.Actors
            self.awardsLabel.adjustsFontSizeToFitWidth = true
            self.genreLabel.adjustsFontSizeToFitWidth = true
            self.actorsLabel.adjustsFontSizeToFitWidth = true
            self.directorLabel.adjustsFontSizeToFitWidth = true
            self.durationLabel.text = self.movie!.Runtime
            
            if let data = NSData(contentsOf: self.imageUrl!) {
                let img = UIImage(data: data as Data)
                self.posterImage.image = img
            }
        })
    }
    
    
    @IBAction func saveToFavorites() {    
        saveToDatabase(imdbID: self.movieImdbID!, onCompletion: {
                (isTaken) in
            
                if isTaken {
                    let alert = UIAlertController(title: "Error",
                                                message: "You have already added this movie to your favorites.",
                                                preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in })
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Saved to Favorites",
                                                  message: "Go on and search for another awesome movies!",
                                                  preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .destructive, handler: { (action) -> Void in })
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
    }

}
