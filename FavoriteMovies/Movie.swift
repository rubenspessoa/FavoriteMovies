//
//  Movie.swift
//  FavoriteMovies
//
//  Created by Rubens Pessoa on 21/03/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation

class Movie {
    var Actors: String?
    var Awards: String?
    var Country: String?
    var Director: String?
    var Genre: String?
    var Language: String?
    var Plot: String?
    var Poster: String?
    var Released: String?
    var Runtime: String?
    var Title: String?
    var Writer: String?
    var Year: String?;
    var imdbID: String
    var imdbRating: String;
    var imdbVotes: String;
    
    init(Actors: String, Awards: String, Country: String, Director: String, Genre: String, Language: String, Plot: String,
         Poster: String, Released: String, Runtime: String, Title: String, Writer: String, Year: String, imdbID: String, imdbRating: String, imdbVotes: String) {
        self.Actors = Actors
        self.Awards = Awards
        self.Country = Country
        self.Director = Director
        self.Genre = Genre
        self.Language = Language
        self.Plot = Plot
        self.Poster = Poster
        self.Released = Released
        self.Runtime = Runtime
        self.Title = Title
        self.Writer = Writer
        self.Year = Year
        self.imdbID = imdbID
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
    }
}

class MovieDAO {
    
    func getMovie(byImdbID: String, completionHandler: @escaping (Movie) -> ()) {
        
        getMovieJSON(byImdbID: byImdbID, completionHandler: {
            (movieDict) in

            let movie: Movie = Movie(Actors: movieDict["Actors"]!, Awards: movieDict["Awards"]!, Country: movieDict["Country"]!, Director: movieDict["Director"]!, Genre: movieDict["Genre"]!, Language: movieDict["Language"]!, Plot: movieDict["Plot"]!, Poster: movieDict["Plot"]!, Released: movieDict["Released"]!, Runtime: movieDict["Runtime"]!, Title: movieDict["Title"]!, Writer: movieDict["Writer"]!, Year: movieDict["Year"]!, imdbID: movieDict["imdbID"]!, imdbRating: movieDict["imdbRating"]!, imdbVotes: movieDict["imdbVotes"]!)
            
            completionHandler(movie)
        })
    }
    
    func getMovies(byName: String, completionHandler: @escaping (() -> ())) {
        
        getMoviesJSON(byName: byName, completionHandler: {
            (moviesDict) in
            print(moviesDict)
            
            completionHandler()
        })
        
    }
}
