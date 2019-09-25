//
//  UIView.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/22/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}
