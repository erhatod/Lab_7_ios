//
//  ViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 11.12.2020.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var key = "dad92eee"
    
    var selectedMovieIndex: Int = 0
    var allMovies: [Movie] = [] {
        didSet {
            showingFilms = allMovies
        }
    }
    var showingFilms: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchFilmViewController {
            vc.film = showingFilms[selectedMovieIndex]
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedMovieIndex = indexPath.row
        self.performSegue(withIdentifier: "detail", sender: self)
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if (searchText.count >= 3) {
//                self.view.isUserInteractionEnabled = false
                let s = searchText.replacingOccurrences(of: " ", with: "+")
                
                print(s)
                let stringUrl = "https://www.omdbapi.com/?s=\(s)&apikey=\(key)&page=1"
                print(stringUrl)
                let url = URL(string: stringUrl)
                if let url = url {
                    let urlRequest = URLRequest(url: url)
                    let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, responce, error) in
                        DispatchQueue.main.async {
                            self.activityIndicator.startAnimating()
                        }
                        if let data = data {
                            var movieArray: [Movie] = []
                            let jsonData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                            if let arrayOfDictionaries = jsonData["Search"] as? [[String: Any]] {

                                
                                for movieDictionary in arrayOfDictionaries {
                                    let movie = Movie(with: movieDictionary)
                                    var posterImage: UIImage? = nil
                                    
                                    if let posterUrl = movie.poster{
                                        if let url = URL(string: posterUrl) {
                                            if let posterImageData = try? Data(contentsOf: url) {
                                                posterImage = UIImage(data: posterImageData)
                                            }
                                        }
                                    }
                                    movie.posterImage = posterImage
                                    movieArray.append(movie)
                                    
                                }


                            }
                            
                            DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
//                                self.view.isUserInteractionEnabled = true
                                self.allMovies = movieArray
                                searchBar.resignFirstResponder()
                                self.tableView.reloadData()
                            }
                        }
                    }
                    dataTask.resume()
                    
                }
            } else {
//                self.view.isUserInteractionEnabled = true
                allMovies = []
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
            
        } else {
//            self.view.isUserInteractionEnabled = true
            allMovies = []
            searchBar.resignFirstResponder()
            self.tableView.reloadData()
        }
        
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
            tableView.reloadData()
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
        cell.poster.image = movie.posterImage
        return cell
    }
    

}

