//
//  FilmViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 11.12.2020.
//

import UIKit

class SearchFilmViewController: UIViewController {
    
    var film: Movie!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var avards: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var plot: UILabel!
    @IBOutlet weak var year: UILabel!
    
    var key = "dad92eee"
    
    @IBOutlet weak var activityController: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = film.title
        update()
        // Do any additional setup after loading the view.
        loadInfo()
    }
    
    func update() {
        self.poster.image = film.posterImage
        self.year.text = "Year: " + (film.year ?? "Unknown")
        self.country.text = "Country: " + (film.country ?? "Unknown")
        self.genre.text = "Genre: " + (film.genre ?? "Unknown")
        self.runtime.text = "Runtime: " + (film.runtime ?? "Unknown")
        self.writer.text = "Writer: " + (film.writer ?? "Unknown")
        self.director.text = "Director: " + (film.director ?? "Unknown")
        self.avards.text = "Avards: " + (film.avards ?? "Unknown")
        self.rating.text = "Rating(imdb): " + (film.imdbRating ?? "Unknown")
        self.actors.text = "Actors: " + (film.actors ?? "Unknown")
        self.plot.text = "Plot: " + (film.plot ?? "Unknown")
    }
    
    
    func loadInfo(){
        
        
        let s = film.imdbID!

        let stringUrl = "https://www.omdbapi.com/?i=\(s)&apikey=\(key)&page=1"
        print(stringUrl)
        let url = URL(string: stringUrl)
        if let url = url {
            let urlRequest = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, responce, error) in
                DispatchQueue.main.async {
                    self.activityController.startAnimating()
                }
                if let data = data {
                    let jsonData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
                    print(jsonData)
                    

                    DispatchQueue.main.async {
                        self.film.addInfo(jsonData)
                        self.update()
                        self.activityController.stopAnimating()
                    }
                }
            }
            dataTask.resume()

        }
        

        
        
    }
}
