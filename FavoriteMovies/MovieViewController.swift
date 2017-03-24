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
            print(self.plotText.text)
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
    

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
