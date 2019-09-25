//
//  ArticleModel.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/24/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import Foundation

struct Article: Decodable {
    let id: Int
    let title: String
    let body: String
}
