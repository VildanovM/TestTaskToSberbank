//
//  NetworkService.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getFilms(completion: @escaping(_ filmsDict: [[String: Any]]?, _ error: Error?) -> ())
}

class NetworkService {
    // MARK: - Приватные свойства
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://swapi.dev/api/")!
    
    
}

// MARK: - Реализация протокола
extension NetworkService: NetworkServiceProtocol {
    func getFilms(completion: @escaping(_ filmsDict: [[String: Any]]?, _ error: Error?) -> ()) {
        let filmURL = baseURL.appendingPathComponent("films")
        urlSession.dataTask(with: filmURL) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                let error = NSError(domain: dataErrorDomain, code: DataErrorCode.networkUnavailable.rawValue, userInfo: nil)
                completion(nil, error)
                return
            }
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonDictionary = jsonObject as? [String: Any], let result = jsonDictionary["results"] as? [[String: Any]] else {
                    throw NSError(domain: dataErrorDomain, code: DataErrorCode.wrongDataFormat.rawValue, userInfo: nil)
                }
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
