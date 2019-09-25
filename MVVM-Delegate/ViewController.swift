//
//  ViewController.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/17/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    
    private lazy var viewModel: ViewModel = {
        return .init()
    }()
    
    private lazy var dataSource: ViewDataSource = {
        return .init(viewModel: self.viewModel)
    }()
    
    fileprivate let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties()
        
        view.addSubviews(searchBar, collectionView)
        layout()
        
        searchBar.delegate = self
        viewModel.delegate = self
        
        dataSource.configure(with: collectionView)

        

    }

    private func setProperties(){
        navigationItem.title = "dwdw"
        view.backgroundColor = .white
    }

}


extension ViewController {
    
    private func layout() {
        
        let searchBarConstraints = [
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(
            searchBarConstraints +
            collectionViewConstraints
        )
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchArticles()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getFeed()
        self.navigationController?.navigationBar.isHidden = false
        var r = self.view.frame
        r.origin.y = 0
        r.size.height -= 44
        
        self.view.frame = r
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.navigationController?.navigationBar.isHidden = true
        var r = self.view.frame
        r.origin.y = -44
        r.size.height += 44
        
        self.view.frame = r
        searchBar.setShowsCancelButton(true, animated: true)
    }
}

extension ViewController: ViewModelDelegate {
    func viewModelDidUpdate(_ viewModel: ViewModel) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

