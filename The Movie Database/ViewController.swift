//
//  ViewController.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var historyTableView: UITableView!
    
    /// Holds the instance of UICollectionViewController from the Container View
    var collectionVC: UICollectionViewController? {
        didSet {
            collectionVC?.collectionView?.delegate = self
            collectionVC?.collectionView?.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        MovieManager.shared.delegate = self
        searchBar.delegate = self
        historyTableView.delegate = self
        historyTableView.dataSource = self
        setupPullToRefresh()
    }
    
    /// Allows pull to refresh
    func setupPullToRefresh() {
        let spring = collectionVC?.collectionView?.addSpringRefresh(position: .top, actionHandlere: { _ in
            MovieManager.shared.clear()
            if let lastSearch = History.items.first {
                MovieManager.shared.search(string: lastSearch)
            }
        })
        spring?.unExpandedColor = UIColor.gray
        spring?.expandedColor = UIColor.white
        spring?.readyColor = UIColor.white
        spring?.affordanceMargin = 0
    }
    
    /// Sets the status bar to white content over black background
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Used to get the instance of collection view in the container view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container" {
            if let containerVC = segue.destination as?UICollectionViewController {
            self.collectionVC = containerVC
            }
            
        }
    }
}

/// Handles the search bar
extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        historyTableView.reloadData()
        historyTableView.isHidden = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        historyTableView.isHidden = true
        searchBar.endEditing(true)
        guard let searchTerm = searchBar.text else { return }
        MovieManager.shared.search(string: searchTerm)
    }
}

/// 
extension ViewController: MovieManagerDelegate {
    func didLoadMovies(noResults: Bool) {
        if noResults {
            print("Hayye Allah")
        } else {
            collectionVC?.collectionView?.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieManager.shared.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionVC?.collectionView?.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = MovieManager.shared.list[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = collectionVC?.collectionViewLayout as! Layout
        let offset = layout.dragOffset * CGFloat(indexPath.item)
        if collectionView.contentOffset.y != offset {
            collectionView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return History.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        cell.string = History.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let historyItem = History.items[indexPath.row]
        MovieManager.shared.search(string: historyItem)
        historyTableView.isHidden = true
        searchBar.endEditing(true)
    }
}

