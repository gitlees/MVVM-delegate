//
//  BaseCell.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/24/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reset()
    }
    
    func reset() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
