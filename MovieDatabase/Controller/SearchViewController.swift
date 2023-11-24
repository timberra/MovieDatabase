//
//  SearchViewController.swift
//  MovieDatabase
//
//  Created by liga.griezne on 22/11/2023.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
