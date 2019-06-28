//
//  Movie.swift
//  MovieList
//
//  Created by Jason Mandozzi on 6/28/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import Foundation

struct TopLevelJson: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String?
    let rating: String?
    let description: String?
    let movieImageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rating = "vote_average"
        case description = "overview"
        case movieImageURL = "poster_path"
    }
}
