//
//  DataProvider.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 29.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import CoreData

class DataProvider {
    
    private let persistentContainer: NSPersistentContainer
    private let filmsRepository: NetworkService
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(persistentContainer: NSPersistentContainer, filmsRepository: NetworkService) {
        self.persistentContainer = persistentContainer
        self.filmsRepository = filmsRepository
    }
    
    func fetchFilms(completion: @escaping(Error?) -> Void) {
        filmsRepository.getFilms() { [weak self] result in
            
            guard let self = self else { return }
            
            let tempJson: [[String: Any]]?
            
            switch result {
            case .failure(let error): print(error.localizedDescription)
            case .success(let data): tempJson = data
            }
            
            guard let result = tempJson else { return }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            taskContext.undoManager = nil
            
            _ = self.syncFilms(jsonDictionary: result, taskContext: taskContext)
            
            completion(nil)
        }
    }
    
    private func syncFilms(jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        taskContext.performAndWait {
            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
            let episodeIds = jsonDictionary.map { $0["episode_id"] as? Int }.compactMap { $0 }
            matchingEpisodeRequest.predicate = NSPredicate(format: "episodeId in %@", argumentArray: [episodeIds])
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingEpisodeRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            
            // Create new records.
            for filmDictionary in jsonDictionary {
                
                guard let film = NSEntityDescription.insertNewObject(forEntityName: "StarWarsFilms", into: taskContext) as? StarWarsFilm else {
                    print("Error: Failed to create a new Film object!")
                    return
                }
                
                do {
                    try film.map(jsonData: filmDictionary)
                } catch {
                    print("Error: \(error)\nThe quake object will be deleted.")
                    taskContext.delete(film)
                }
            }
            
            // Save all the changes just made and reset the taskContext to free the cache.
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                taskContext.reset() // Reset the context to clean up the cache and low the memory footprint.
            }
            successfull = true
        }
        return successfull
    }
}

