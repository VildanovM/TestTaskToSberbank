//
//  StackCoreData.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import CoreData

protocol StackCoreDataProtocol {
    var persistentContainer: NSPersistentContainer { get }
}

final class StackCoreData: StackCoreDataProtocol {
    // MARK: - Свойства
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Film")
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Ошибка! Информация: \(error), \(error.userInfo)")
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
}
