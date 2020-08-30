//
//  MainViewTests.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 31.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest

class MainViewTests: XCTestCase {

    func testThatConfigurateWithoutPresenter() {
        let mainView = MainTableViewController()
        
        mainView.viewDidLoad()
        XCTAssertTrue(!mainView.fetchedResultsController.accessibilityElementsHidden)
    }

}
