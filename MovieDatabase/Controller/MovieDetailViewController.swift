//
//  MovieDetailViewController.swift
//  MovieDatabase
//
//  Created by liga.griezne on 23/11/2023.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movieDetails: MovieDetails?

    @IBOutlet weak var movieDetailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var movieTitle: String?
    var movieLanguage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let title = movieTitle {
            titleLabel.text = title
        }
        if let language = movieLanguage {
            movieDetailLabel.text = language
        }
    }
}


