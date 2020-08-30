//
//  DataProviderTest.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest

class DataProviderTest: XCTestCase {
    
    func testThatDataProviderGetNonErrorRequest() {
        // Arrange
        let stackCoreData = StackCoreData()
        let networkService = NetworkService()
        let dataProvider = DataProvider(persistentContainer: stackCoreData.persistentContainer, repository: networkService)
        // Act
        dataProvider.fetchFilms { error in
            // Assert
            XCTAssertNil(error)
        }
        
    }
    
    func testThatDataProviderGetRequest() {
        // Arrange
        let stackCoreData = StackCoreData()
        let networkService = NetworkService()
        let dataProvider = DataProvider(persistentContainer: stackCoreData.persistentContainer, repository: networkService)
        // Act
        let result = dataProvider.syncFilms(jsonDictionary: [["Foo": "Bar"]], taskContext: dataProvider.viewContext)
        // Assert
        XCTAssertFalse(result)
        
    }
    
}
