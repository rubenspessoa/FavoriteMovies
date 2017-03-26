//
//  FavoritesViewController.swift
//  FavoriteMovies
//
//  Created by Rubens Pessoa on 26/03/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import UIKit
import Parse
import Kingfisher

class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let movieDAO: MovieDAO = MovieDAO()
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllMovies(onCompletion: {
            (objects) in
            
            DispatchQueue.main.async {
                let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
                spinnerActivity.label.text = "Loading";
                spinnerActivity.isUserInteractionEnabled = false;
            }
            
            var moviesImdbIds: [String] = []
            var moviesAux: [Movie] = []
            
            for obj: PFObject in objects! {
                moviesImdbIds.append(obj["imdbID"] as! String)
            }
            
            for id: String in moviesImdbIds {
                print("Pegando cada movie by id")
                
                self.movieDAO.getMovie(byImdbID: id, completionHandler: {
                    (movie) in
                    
                    moviesAux.append(movie)
                    self.movies = moviesAux
                    self.collectionView.reloadData()
                })
            }
            
            DispatchQueue.main.async {
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as! FavoritesCollectionViewCell
        
        let imageUrlStr: String = self.movies[indexPath.row].Poster!
        let imageUrl: URL = URL(string: imageUrlStr)!
        
        let resource = ImageResource(downloadURL: imageUrl, cacheKey: imageUrlStr)
        cell.posterImage.kf.setImage(with: resource)
        
        /*
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = NSData(contentsOf: imageUrl) {
                let img = UIImage(data: data as Data)
                DispatchQueue.main.async {
                    cell.posterImage.image = img
                }
            }
        } */
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSegue2" {
            if let vc = segue.destination as? MovieViewController {
                let cell = sender as! FavoritesCollectionViewCell
                let indexPath = self.collectionView!.indexPath(for: cell)?.row
                let movieSelectedID = self.movies[indexPath!].imdbID
                vc.movieImdbID = movieSelectedID!
                vc.cameFromFavorites = true
            }
        }
    }
    

}
