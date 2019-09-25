//
//  ApiService.swift
//  MVVM-Delegate
//
//  Created by Stas Lee on 9/24/19.
//  Copyright © 2019 Stas Lee. All rights reserved.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    
    func SearchArticles(searchText: String,completion: @escaping (Result<[Article], Error>) -> ()){
        guard !searchText.isEmpty else {return}
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?title=\(searchText)") else {return}
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err{
                completion(.failure(err))
            } else{
                
                if let data = data {
                    do{
                        let response = try JSONDecoder().decode([Article].self, from: data)
                        completion(.success(response))
                    } catch let jsonError{
                        completion(.failure(jsonError))
                    }
                }
            }
        }.resume()
    }

    
    func GetArticles(completion: @escaping (Result<[Article], Error>) -> ()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err{
                completion(.failure(err))
            } else{
                
                if let data = data {
                    do{
                        let response = try JSONDecoder().decode([Article].self, from: data)
                        completion(.success(response))
                    } catch let jsonError{
                        completion(.failure(jsonError))
                    }
                }
            }
            }.resume()
    }
}
