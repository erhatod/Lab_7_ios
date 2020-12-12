//
//  ViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 29.11.2020.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var selectedMovieIndex: Int = 0
    var allMovies: [Movie] = [] {
        didSet {
            showingFilms = allMovies
        }
    }
    var showingFilms: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeJson()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilmViewController {
            vc.film = showingFilms[selectedMovieIndex]
        }
        if let vc = segue.destination as? AddFilmViewController {
            vc.parentVC = self
        }
    }
    
    func decodeJson() {
        var movieArray: [Movie] = []
        
        for movie_id in 1...10 {
            let resourceUrl = Bundle.main.url(forResource: "movie_\(movie_id)", withExtension: ".txt")!
            let data = try! Data(contentsOf: resourceUrl)
            let jsonData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            movieArray.append(Movie(with: jsonData))
        }
        
        self.allMovies = movieArray
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedMovieIndex = indexPath.row
        self.performSegue(withIdentifier: "detail", sender: self)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                var showingFilms: [Movie] = []
                for film in allMovies {
                    if film.title!.lowercased().contains(searchText.lowercased()) {
                        showingFilms.append(film)
                    }
                }
                print(showingFilms.map { $0.title })
                self.showingFilms = showingFilms
                
                
            } else {
                showingFilms = allMovies
            }
        }
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removingFilm = showingFilms[indexPath.row]
            var allFilms: [Movie] = []
            for film in allMovies {
                if !(removingFilm === film) {
                    allFilms.append(film)
                }
            }
            
            self.allMovies = allFilms
            searchBarSearchButtonClicked(searchBar)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showingFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        let movie = showingFilms[indexPath.row]
        cell.title.text = movie.title
        cell.year.text = movie.year
        cell.type.text = movie.type
        
        if let _ = movie.poster {
            if !movie.poster!.isEmpty {
                let image = UIImage(named: movie.poster!)
                cell.poster.image = image
            }
            else{
                cell.poster.image = nil
            }
        } else {
            cell.poster.image = nil
        }
        
        
        return cell
    }
    
}

