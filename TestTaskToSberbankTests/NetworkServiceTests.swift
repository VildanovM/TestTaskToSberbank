//
//  NetworkServiceTests.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest
@testable import TestTaskToSberbank

class NetworkServiceTests: XCTestCase {

    func testThatNetworkServiceMakeRequest() {
        // Arrange
        let expectation = XCTestExpectation(description: "Download Star Wars repositories")
        let networkService = NetworkService()
        
        // Act
        networkService.getFilms { (result, error) in
            // Assert
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
    }

}
