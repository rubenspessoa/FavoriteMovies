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
    var Year: String?
    var imdbID: String?
    var imdbRating: String?
    var imdbVotes: String?
    
    init(Actors: String?, Awards: String?, Country: String?, Director: String?, Genre: String?, Language: String?, Plot: String?,
         Poster: String?, Released: String?, Runtime: String?, Title: String?, Writer: String?, Year: String?, imdbID: String?, imdbRating: String?, imdbVotes: String?) {
        
        if let actorsTest = Actors {
            self.Actors = actorsTest
        } else {
            self.Actors = nil
        }
        
        if let awardsTest = Awards {
            self.Awards = awardsTest
        } else {
            self.Awards = nil
        }
        
        if let countryTest = Country {
            self.Country = countryTest
        } else {
            self.Country = nil
        }
        
        if let directorTest = Director {
            self.Director = directorTest
        } else {
            self.Director = nil
        }
        
        if let genreTest = Genre {
            self.Genre = genreTest
        } else {
            self.Genre = nil
        }
        
        if let languageTest = Language {
            self.Language = languageTest
        } else {
            self.Language = nil
        }
        
        if let plotTest = Plot {
            self.Plot = plotTest
        } else {
            self.Plot = nil
        }
        
        if let releasedTest = Released {
            self.Released = releasedTest
        } else {
            self.Released = nil
        }
        
        if let runtimeTest = Runtime {
            self.Runtime = runtimeTest
        } else {
            self.Runtime = nil
        }
        
        if let titleTest = Title {
            self.Title = titleTest
        } else {
            self.Title = nil
        }
        
        if let writerTest = Writer {
            self.Writer = writerTest
        } else {
            self.Writer = nil
        }
        
        if let yearTest = Year {
            self.Year = yearTest
        } else {
            self.Year = nil
        }
        
        if let imdbIDTest = imdbID {
            self.imdbID = imdbIDTest
        } else {
            self.imdbID = nil
        }
        
        if let imdbRatingTest = imdbRating {
            self.imdbRating = imdbRatingTest
        } else {
            self.imdbRating = nil
        }
        
        if let imdbVotesTest = imdbVotes {
            self.imdbVotes = imdbVotesTest
        } else {
            self.imdbVotes = nil
        }
        
        if let posterTest = Poster {
            self.Poster = posterTest
        } else {
            self.Poster = nil
        }
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
    
    func getMovies(byName: String, completionHandler: @escaping (([Movie]) -> ())) {
        
        getMoviesJSON(byName: byName, completionHandler: {
            (mvJSON) in
            
            let listMovies: [[String:String]] = mvJSON["Search"] as! [[String: String]]
            
            var movies: [Movie] = []
            
            for movieDict: [String: String] in listMovies {
                var actors: String?
                var awards: String?
                var country: String?
                var director: String?
                var genre: String?
                var language: String?
                var plot: String?
                var released: String?
                var runtime: String?
                var title: String?
                var writer: String?
                var year: String?
                var imdbID: String?
                var imdbRating: String?
                var imdbVotes: String?
                var poster: String?
                
                if let actorsTest = movieDict["Actors"] {
                    actors = actorsTest
                } else {
                    actors = nil
                }
                
                if let awardsTest = movieDict["Awards"] {
                    awards = awardsTest
                } else {
                    awards = nil
                }
                
                if let countryTest = movieDict["Country"] {
                    country = countryTest
                } else {
                    country = nil
                }
                
                if let directorTest = movieDict["Director"] {
                    director = directorTest
                } else {
                    director = nil
                }
                
                if let genreTest = movieDict["Genre"] {
                    genre = genreTest
                } else {
                    genre = nil
                }
                
                if let languageTest = movieDict["Language"] {
                    language = languageTest
                } else {
                    language = nil
                }
                
                if let plotTest = movieDict["Plot"] {
                    plot = plotTest
                } else {
                    plot = nil
                }
                
                if let releasedTest = movieDict["Released"] {
                    released = releasedTest
                } else {
                    released = nil
                }
                
                if let runtimeTest = movieDict["Runtime"] {
                    runtime = runtimeTest
                } else {
                    runtime = nil
                }
                
                if let titleTest = movieDict["Title"] {
                    title = titleTest
                } else {
                    title = nil
                }
                
                if let writerTest = movieDict["Writer"] {
                    writer = writerTest
                } else {
                    writer = nil
                }
                
                if let yearTest = movieDict["Year"] {
                    year = yearTest
                } else {
                    year = nil
                }
                
                if let imdbIDTest = movieDict["imdbID"] {
                    imdbID = imdbIDTest
                } else {
                    imdbID = nil
                }
                
                if let imdbRatingTest = movieDict["imdbRating"] {
                    imdbRating = imdbRatingTest
                } else {
                    imdbRating = nil
                }
                
                if let imdbVotesTest = movieDict["imdbVotes"] {
                    imdbVotes = imdbVotesTest
                } else {
                    imdbVotes = nil
                }
                
                if let posterTest = movieDict["Poster"] {
                    poster = posterTest
                } else {
                    poster = nil
                }

                let movie: Movie = Movie(Actors: actors, Awards: awards, Country: country, Director: director, Genre: genre, Language: language, Plot: plot, Poster: poster, Released: released, Runtime: runtime, Title: title, Writer: writer, Year: year, imdbID: imdbID, imdbRating: imdbRating, imdbVotes: imdbVotes)
                
                movies.append(movie)
            }
            completionHandler(movies)
        })
        
    }
}
