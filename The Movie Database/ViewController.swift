//
//  ViewController.swift
//  The Movie Database
//
//  Created by Furqan on 17/05/2017.
//  Copyright © 2017 Careem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MovieManagerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
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
    }
    
    func didLoadMovies(noResults: Bool) {
        if noResults {
            print("Hayye Allah")
        } else {
            collectionVC?.collectionView?.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "container" {
            if let containerVC = segue.destination as?UICollectionViewController {
            self.collectionVC = containerVC
            }
            
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        guard let searchTerm = searchBar.text else { return }
        MovieManager.shared.search(string: searchTerm)
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

