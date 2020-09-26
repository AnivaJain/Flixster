//
//  MovieData.swift
//  Flixster
//
//  Created by Sambhav Jain on 9/22/20.
//  Copyright © 2020 CodingNinjas. All rights reserved.
//

import Foundation

public struct MovieData: Codable {
    let results: [Movie]
}
    
  public struct Movie: Codable {
        let title: String
        let overview: String
        let poster_path: String
    }


