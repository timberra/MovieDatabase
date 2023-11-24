//
//  ViewController.swift
//  MovieDatabase
//
//  Created by liga.griezne on 22/11/2023.
//


import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    var movies:[Movie] = []
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var homeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies(url: Constants.API.popularMoviesUrl)
    }
    private func getMovies(url: String) {
        NetworkManager.fetchMovies(url: url) { [weak self] movies in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.movies = movies.results ?? []
                self.homeTableView.reloadData()
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func activityIndicator(activityIndicatorView: UIActivityIndicatorView, animated: Bool) {
        DispatchQueue.main.async{
            if animated{
                activityIndicatorView.isHidden = false
                activityIndicatorView.startAnimating()
            }
            else{
                activityIndicatorView.isHidden = true
                activityIndicatorView.startAnimating()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.5){
            cell.transform = CGAffineTransform.identity
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell",for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = Constants.Icon.overview + (movie.overview != "" ? movie.overview! : "Plot unknown")
        
        if movie.voteAverage != 0.0 {
            cell.ratingLabel.isHidden = false
            cell.ratingLabel.text = Constants.Icon.rating + String(format: "%f", movie.voteAverage!)
        }else{
            cell.ratingLabel.isHidden = true
        }
        
        cell.releaseDateLabel.text = Constants.Icon.releaseDate + movie.releaseDate!
        cell.posterImageView.sd_setImage(with: URL(string: Constants.API.posterUrl.appending(movie.posterPath ?? "")))
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.RowHeight.homeTableViewCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        showMovieDetailViewController(with: movie.title, language: movie.originalLanguage)
    }

    func showMovieDetailViewController(with title: String?, language: String?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            movieDetailVC.movieTitle = title
            movieDetailVC.movieLanguage = language
            navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
}


