//
//  DataProvider.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 29.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import CoreData

protocol DataProviderProtocol {
    var viewContext: NSManagedObjectContext { get }
    func fetchFilms(completion: @escaping(Error?) -> Void)
}

class DataProvider {
    
    // MARK: - Свойства
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    // MARK: - Приватные свойства
    private let persistentContainer: NSPersistentContainer
    private let repository: NetworkServiceProtocol?
    
    init(persistentContainer: NSPersistentContainer, repository: NetworkServiceProtocol) {
        self.persistentContainer = persistentContainer
        self.repository = repository
    }
    
    
    private func syncFilms(jsonDictionary: [[String: Any]], taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        taskContext.performAndWait {
            let matchingEpisodeRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
            let episodeIds = jsonDictionary.map { $0["episode_id"] as? Int }.compactMap { $0 }
            matchingEpisodeRequest.predicate = NSPredicate(format: "episodeId in %@", argumentArray: [episodeIds])
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingEpisodeRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            
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
            
            // Создает новую запись
            for filmDictionary in jsonDictionary {
                
                guard let film = NSEntityDescription.insertNewObject(forEntityName: "Film", into: taskContext) as? Film else {
                    print("Error: Failed to create a new Film object!")
                    return
                }
                
                do {
                    try film.update(with: filmDictionary)
                } catch {
                    print("Error: \(error)\nThe quake object will be deleted.")
                    taskContext.delete(film)
                }
            }
            
            // Сохраняет все изменения
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                taskContext.reset() // Сбрасывает контекст
            }
            successfull = true
        }
        return successfull
    }
}

// MARK: - Реализация протокола
extension DataProvider: DataProviderProtocol {
    func fetchFilms(completion: @escaping(Error?) -> Void) {
        guard let repository = repository else { return }
        repository.getFilms() { jsonDictionary, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let jsonDictionary = jsonDictionary else {
                let error = NSError(domain: dataErrorDomain, code: DataErrorCode.wrongDataFormat.rawValue, userInfo: nil)
                completion(error)
                return
            }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            taskContext.undoManager = nil
            
            _ = self.syncFilms(jsonDictionary: jsonDictionary, taskContext: taskContext)
            
            completion(nil)
        }
    }
}
