//
//  RootTableViewController.swift
//  
//
//  Created by Rubens Pessoa on 21/03/17.
//
//

import UIKit

class RootTableViewController: UITableViewController, UISearchResultsUpdating {

    let movieDAO: MovieDAO = MovieDAO()
    var movies: [Movie] = []
    
    @IBOutlet weak var rootTableView: UITableView!
    
    var searchController: UISearchController!
    //var resultsController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootTableView.dataSource = self
        rootTableView.delegate = self
        //self.resultsController.tableView.dataSource = self
        //self.resultsController.tableView.delegate = self
        
        self.searchController = UISearchController(searchResultsController: nil)
        self.rootTableView.tableHeaderView = self.searchController.searchBar
        self.searchController.searchResultsUpdater = self
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let inputTest = self.searchController.searchBar.text {
            if inputTest != "" {
                do {
                    try movieDAO.getMovies(byName: self.searchController.searchBar.text!.lowercased(), completionHandler: {
                        moviesList in
                        self.movies = moviesList
                        self.rootTableView.reloadData()
                    })
                } catch is NSException {
                    print("Deu ruim negaum")
                }
            }
        } else {
            // Doesn't have any input
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: separar por gênero
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)

        cell.textLabel?.text = movies[indexPath.row].Title
        cell.detailTextLabel?.text = movies[indexPath.row].Year
        
        return cell
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
