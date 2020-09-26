//
//  MovieViewController.swift
//  Flixster
//
//  Created by Sambhav Jain on 9/19/20.
//  Copyright © 2020 CodingNinjas. All rights reserved.
//

import UIKit
import AlamofireImage

// Step 1: Add UITableView
//



class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
   
    @IBOutlet weak var tableView: UITableView!
    
    //  var arrayMovies: [MovieData.Movie] = []
    //   var title: String = ""
    //  var synopsis: String = ""
    
    
    // This is an creationg of an array of Dictionary.
    // This is a dic? var movie = [String: Any]
    // This is an array of dic var movie - [[String : Any]]()
    var movies = [[String:Any]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any] // as! [String: Any] -> Casting in Swift
              self.movies = dataDictionary["results"] as! [[String:Any]]
              self.tableView.reloadData()
           }
        }
        task.resume()
    }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movies.count
        }
           
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
                    
            let movie = movies[indexPath.row]
            let title = movie["title"] as! String
            let synopsis = movie["overview"] as! String
            cell.titleLabel.text = title
            cell.synopsisLabel.text = synopsis
            
            let baseUrl = "https://image.tmdb.org/t/p/w185"
            let posterPath = movie["poster_path"] as! String
            let posterUrl = URL(string: baseUrl + posterPath)
            cell.posterView.af_setImage(withURL: posterUrl!)
            return cell
        }
}
