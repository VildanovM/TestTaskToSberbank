//
//  NetworkService.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFilms(completion: @escaping (Result<[[String: Any]]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func getFilms(completion: @escaping (Result<[[String: Any]]?, Error>) -> Void){
        let urlString = "https://swapi.dev/api/films/"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                
                completion(.failure(error))
                return
                
            }
            
            do {
//                let objectJSON = try JSONDecoder().decode([Comment].self, from: data!)
//                completion(.success(objectJSON))
                guard let data = data else { return }
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDictionary = jsonObject as? [String: Any], let result = jsonDictionary["results"] as? [[String: Any]] else { return }
                completion(.success(result))
                
            } catch {
                
                completion(.failure(error))
                
            }
        }.resume()
    }
    
    
        
    
}
