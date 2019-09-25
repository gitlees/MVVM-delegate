//
//  ViewDataSource.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/24/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import UIKit

final class ViewDataSource: NSObject {
    enum Const {
        static let cellReuseId = "cellId"
    }
    
    private unowned let viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    func configure(with collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArticleViewCell.self, forCellWithReuseIdentifier: Const.cellReuseId)
    }
}

extension ViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: UIScreen.main.bounds.width-16, height: 100)
    }

}

extension ViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfArticles
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.cellReuseId, for: indexPath) as! ArticleViewCell
        cell.configure(with: viewModel.article(at: indexPath.row))
        return cell
    }
    
    
}
