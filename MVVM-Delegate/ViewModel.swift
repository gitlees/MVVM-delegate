//
//  ViewModel.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/24/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import UIKit

protocol ViewModelDelegate: class {
    func viewModelDidUpdate(_ viewModel: ViewModel)
}

final class ViewModel {
    
    init() {
        requestFeed()
    }
    
    weak var delegate: ViewModelDelegate?
    
    var searchText: String? {
        didSet {
            removeSearchTimer()
            startSearchTimer()
        }
    }
    var numberOfArticles: Int {
        return articles.count
    }

    private var searchTimer: Timer?
    
    private var articles: [Article] = [] {
        didSet {
            delegate?.viewModelDidUpdate(self)
        }
    }

    func article(at index: Int) -> Article {
        return articles[index]
    }
    
    func getFeed(){
        requestFeed()
    }
    
    func searchArticles() {
        removeSearchTimer()
        searchTimerCompleted()
    }
    
    private func startSearchTimer() {
        searchTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(searchTimerCompleted), userInfo: nil, repeats: false)
    }
    
    private func removeSearchTimer() {
        searchTimer?.invalidate()
        searchTimer = nil
    }
    
    private func requestArticles(searchText: String){
        let formattedSearchText = searchText.lowercased().replacingOccurrences(of: " ", with: "%20")
        ApiService.shared.SearchArticles(searchText: formattedSearchText) { (res) in
            switch(res){
                case .success(let response):
                    self.articles = response
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func requestFeed(){
        ApiService.shared.GetArticles { (res) in
            switch(res){
            case .success(let response):
                self.articles = response
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func searchTimerCompleted() {
        guard let searchText = searchText else {return}
        requestArticles(searchText: searchText)
    }
}
