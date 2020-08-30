//
//  RouterTest.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest
@testable import TestTaskToSberbank


class RouterTest: XCTestCase {
    
    func testThatRouterCreateInitialViewController() {
        // Arrange
        let assemblyBuilder = AssemblyModelBuilder()
        let navigationController = MockNavigationController()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        // Act
        router.initialViewController()
        // Assert
        XCTAssertTrue(!navigationController.viewControllers.isEmpty)
        
    }
    func testThatRouterPushToDetailViewController() {
        // Arrange
        let assemblyBuilder = AssemblyModelBuilder()
        let navigationController = MockNavigationController()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        // Act
        router.showDetail(film: nil)
        let detailViewController = navigationController.presentedVC
        // Assert
        XCTAssertTrue(detailViewController is DetailViewController)
        
    }
    
    func testThatRouterPopToRootNotDeleteViewControllers() {
        // Arrange
        let assemblyBuilder = AssemblyModelBuilder()
        let navigationController = MockNavigationController()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        // Act
        router.showDetail(film: nil)
        router.popToRoot()
        // Assert
        XCTAssertTrue(!navigationController.viewControllers.isEmpty)
    }


}
