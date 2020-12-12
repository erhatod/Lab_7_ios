//
//  FilmViewController.swift
//  My great app
//
//  Created by Oleksii Afonin on 30.11.2020.
//

import UIKit

class FilmViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = film.title
        self.poster.image = UIImage(named: film.poster ?? "")
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
        // Do any additional setup after loading the view.
    }

}
