//
//  MovieController.swift
//  MovieList
//
//  Created by Jason Mandozzi on 6/28/19.
//  Copyright © 2019 Jason Mandozzi. All rights reserved.
//

import UIKit

class MovieController {
    //creating our query to conform to this url
    //https://api.themoviedb.org/3/search/movie?api_key=18abaabe4391bdf77d1c6ee1a79a24dc&query=Fight%20Club
    let apiKey = "18abaabe4391bdf77d1c6ee1a79a24dc"
    let movieResults: [Movie] = []
    static let baseURL = URL(string: "https://api.themoviedb.org/3/search/movie")
    
    static func fetchMovieItem(apiKey: String, searchQuery: String, completion: @escaping ([Movie]?) -> Void) {
        guard let url = baseURL else {completion(nil); return}
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
         let keySeachQuery = URLQueryItem(name: "api_key", value: apiKey)
        let movieSearchQuery = URLQueryItem(name: "query", value: searchQuery)
        components?.queryItems = [keySeachQuery, movieSearchQuery]
        
        guard let finalURL = components?.url else {completion(nil); return}
        
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("the search didn't work: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            
            do {
                let jsdecoder = JSONDecoder()
                let topLevelJson = try jsdecoder.decode(TopLevelJson.self, from: data)
                completion(topLevelJson.results)
            } catch {
                print("error decoding the data")
                completion(nil)
                return
            }
        }; dataTask.resume()
    }
    
    static func fetchImageFor(movie: Movie, completion: @escaping (UIImage?) -> Void ) {
        let urlForImage = movie.movieImageURL
        let dataTask = URLSession.shared.dataTask(with: urlForImage) { (data, _, error) in
            if let error = error {
                print("Error fetching the image data \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("didn't fetch properly")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }; dataTask.resume()
    }
}
