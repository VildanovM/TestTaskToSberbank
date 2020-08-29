//
//  StarWarsFilm.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import CoreData

class StarWarsFilm: NSManagedObject {
    
    @NSManaged var producer: String
    @NSManaged var title: String
    @NSManaged var director: String
    @NSManaged var openingCrawl: String
    @NSManaged var episodeId: NSNumber
    @NSManaged var releaseDate: Date
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM YYYY"
        return dateFormatter
    }()
    
    func map(jsonData: [String: Any]) throws {
        guard let director = jsonData["director"] as? String,
            let openingCrawl = jsonData["opening_crawl"] as? String,
            let producer = jsonData["producer"] as? String,
            let title = jsonData["title"] as? String,
            let episodeId = jsonData["episode_id"] as? Int,
            let releaseDate = jsonData["release_date"] as? String
            else {
                throw NSError(domain: "", code: 501, userInfo: nil)
        }
        
        self.director = director
        self.episodeId = NSNumber(value: episodeId)
        self.openingCrawl = openingCrawl
        self.producer = producer
        self.releaseDate = StarWarsFilm.dateFormatter.date(from: releaseDate) ?? Date(timeIntervalSince1970: 0)
        self.title = title
    }

}

