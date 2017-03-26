//
//  ParseAPI.swift
//  FavoriteMovies
//
//  Created by Rubens Pessoa on 25/03/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import Parse

func saveToDatabase(imdbID: String, onCompletion: @escaping (Bool) -> ()) {
    let query: PFQuery = PFQuery(className: "favorite_movies")
    query.whereKey("imdbID", equalTo: imdbID)
    query.cachePolicy = .cacheThenNetwork
    
    var isTaken: Bool = false
    
    query.findObjectsInBackground { (objects:[PFObject]?, error:Error?) in
        if error == nil {
            if (objects!.count > 0) {
                isTaken = true
            } else {
                let object = PFObject(className: "favorite_movies")
                
                object["imdbID"] = imdbID
                
                object.saveInBackground(block: {
                    (done:Bool, error:Error?) in
                    
                    if done {
                        print("saved")
                    } else {
                        print(error!)
                    }
                })
            }
        } else {
            print(error!)
        }
        
        onCompletion(isTaken)
    }
}

func getAllMovies(onCompletion: @escaping ([PFObject]?) -> ()) {
    let query: PFQuery = PFQuery(className: "favorite_movies")
    query.whereKeyExists("imdbID")
    query.cachePolicy = .cacheThenNetwork
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
        if (error == nil && objects!.count > 0) {
            onCompletion(objects!)
        } else if (error != nil){
            print(error!)
        }
    }
}

func deleteMovie(imdbId: String, onCompletion: @escaping () -> ()) {
    let query: PFQuery = PFQuery(className: "favorite_movies")
    query.whereKey("imdbID", equalTo: imdbId)
    query.cachePolicy = .cacheThenNetwork
    query.findObjectsInBackground() {
        (objects: [PFObject]?, error: Error?) in
        if (error == nil && objects!.count > 0) {
            for object: PFObject in objects! {
                object.deleteEventually()
                onCompletion()
            }
        } else if (error != nil){
            print(error!)
        }
    }
}
