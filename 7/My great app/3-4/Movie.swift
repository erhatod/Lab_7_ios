//
//  Movie.swift
//  My great app
//
//  Created by Oleksii Afonin on 29.11.2020.
//

import Foundation

class Movie {
    
    var title: String? 
    var year: String?
    var imdbID: String?
    var type: String?
    var poster: String?
    var country: String?
    var language: String?
    var imbVotes: String?
    var production: String?
    var released: String?
    var runtime: String?
    var rated: String?
    var writer: String?
    var plot: String?
    var director: String?
    var genre: String?
    var imdbRating: String?
    var avards: String?
    var imbID: String?
    var actors: String?
    var imdbVotes: String?
    
    
    init(with dictionary: [String: Any]) {
        self.title = dictionary["Title"] as? String
        self.year = dictionary["Year"] as? String
        self.imdbID = dictionary["imdbID"] as? String
        self.type = dictionary["Type"] as? String
        self.poster = (dictionary["Poster"] as? String) ?? ""
        self.country = dictionary["Country"] as? String
        self.language = dictionary["Language"] as? String
        self.imbVotes = dictionary["imbVotes"] as? String
        self.production = dictionary["Production"] as? String
        self.released = dictionary["Released"] as? String
        self.runtime = dictionary["Runtime"] as? String
        self.rated = dictionary["Rated"] as? String
        self.plot = dictionary["Plot"] as? String
        self.director = dictionary["Director"] as? String
        self.writer = dictionary["Writer"] as? String
        self.genre = dictionary["Genre"] as? String
        self.imdbRating = dictionary["imdbRating"] as? String
        self.avards = dictionary["Awards"] as? String
        self.imbID = dictionary["imbID"] as? String
        self.actors = dictionary["Actors"] as? String
        self.imdbVotes = dictionary["imdbVotes"] as? String
    }
    
    init(title: String, type: String, year: String) {
        self.title = title
        self.year = year
        self.type = type
    }
}
