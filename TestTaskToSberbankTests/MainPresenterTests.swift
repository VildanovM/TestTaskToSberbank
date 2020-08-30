//
//  MainPresenterTests.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest
import CoreData

class MainPresenterTests: XCTestCase {
    
    
    func testThatMainPresenterSetupCorrectly() {
        // Arrange
        let stackCoreData = StackCoreData()
        let networkService = NetworkService()
        let dataProvider = DataProvider(persistentContainer: stackCoreData.persistentContainer, repository: networkService)
        let mockNavigationController = MockNavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let router = Router(navigationController: mockNavigationController, assemblyBuilder: assemblyBuilder)
        let mainPresenter = MainPresenter(dataProvider: dataProvider, router: router)
        // Act
        mainPresenter.tapOnTheFilm(film: StarWars(producer: "Foo", title: "Bar", director: "Foo", openingCrawl: "Foo", episodeId: 1, releaseDate: "Bar"))
        
        // Assert
        XCTAssertNil(router.navigationController?.viewControllers.first as? MainTableViewController)
        
    }
    
    func testThatMainPresenterMakeGetFilmsWithoutDataProvider() {
        // Arrange
        let mockNavigationController = MockNavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let router = Router(navigationController: mockNavigationController, assemblyBuilder: assemblyBuilder)
        let mainPresenter = MainPresenter(dataProvider: nil, router: router)
        let view = MainTableViewController()
        view.presenter = mainPresenter
        mainPresenter.view = view
        // Act
        mainPresenter.getFilms()
        let index = IndexPath(row: 0, section: 0)
        
        // Assert
        XCTAssertNil(view.tableView.cellForRow(at: index))
        
    }
    
}
