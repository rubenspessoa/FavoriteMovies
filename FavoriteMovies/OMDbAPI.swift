//
//  OMDbAPI.swift
//  FavoriteMovies
//
//  Created by Rubens Pessoa on 20/03/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import Alamofire

// TODO: Handle errors

func getMovieJSON(byImdbID: String, completionHandler: @escaping (Dictionary<String, String>) -> ()) {
    Alamofire.request("https://www.omdbapi.com/?i=\(byImdbID)").responseJSON {
        response in
        if let json = response.result.value {
            completionHandler(json as! Dictionary<String, String>)
        }
    }
}

func getMoviesJSON(byName: String, completionHandler: @escaping (Dictionary<String, Any>?) -> ()) {
    Alamofire.request("https://www.omdbapi.com/?s=\(byName)&type=movie").responseJSON {
        response in
        
        switch response.result {
            
        case .success(let value):
                let json = value
                completionHandler(json as? Dictionary<String, Any>)
        case .failure(let error):
                completionHandler(nil)
        }
    }
}
