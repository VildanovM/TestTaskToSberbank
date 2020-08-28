//
//  NetworkService.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        
        let urlString = "https://jsonplaceholder.typicode.com/comments"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                
                completion(.failure(error))
                return
                
            }
            
            do {
                
                let objectJSON = try JSONDecoder().decode([Comment].self, from: data!)
                completion(.success(objectJSON))
                
            } catch {
                
                completion(.failure(error))
                
            }
        }.resume()
    }
    
}
