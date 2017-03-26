//
//  RootTableViewController.swift
//
//
//  Created by Rubens Pessoa on 21/03/17.
//
//

import UIKit
import Parse
import Kingfisher

class RootTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let movieDAO: MovieDAO = MovieDAO()
    var movies: [Movie] = []
    var moviesImdbIds: [String] = []
    
    @IBOutlet weak var rootTableView: UITableView!
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootTableView.dataSource = self
        rootTableView.delegate = self
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.rootTableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.barTintColor = self.rootTableView.backgroundColor!
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        if let inputTest = self.searchController.searchBar.text {
            
            if inputTest != "" {
                

                let inputFixed: String = inputTest.replacingOccurrences(of: " ", with: "_")
                movieDAO.getMovies(byName: inputFixed.lowercased(), completionHandler: {
                    moviesList in
                    
                    DispatchQueue.main.async {
                        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
                        spinnerActivity.label.text = "Loading";
                        spinnerActivity.isUserInteractionEnabled = false;
                    }
                    
                    self.movies = moviesList
                    self.rootTableView.reloadData()
                    
                    DispatchQueue.main.async {
                        MBProgressHUD.hideAllHUDs(for: self.view, animated: true);
                    }
                })
                
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! MovieSearchTableViewCell
        
        cell.titleLabel.text = movies[indexPath.row].Title
        cell.yearLabel.text = movies[indexPath.row].Year
        let imageString: String = self.movies[indexPath.row].Poster!
        let imageUrl: URL? = URL(string: imageString)
        
        let resource = ImageResource(downloadURL: imageUrl!, cacheKey: imageString)
        cell.posterImage.kf.setImage(with: resource)
        
        /*
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = NSData(contentsOf: imageUrl!) {
                let img = UIImage(data: data as Data)
                DispatchQueue.main.async {
                    cell.posterImage.image = img
                }
            }
        }
 
        */
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex = tableView.indexPathForSelectedRow?.row
        let movieSelectedID = self.movies[selectedIndex!].imdbID
        
        if segue.identifier == "movieSegue" {
            if let vc = segue.destination as? MovieViewController {
                vc.movieImdbID = movieSelectedID!
            }
        }
    }
    
}
