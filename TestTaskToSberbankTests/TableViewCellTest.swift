//
//  TableViewCellTest.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest

class TableViewCellTest: XCTestCase {

    func testThatCellHasImage() {
        // Arrange
        let viewCell = TableViewCell()
        // Act
        
        // Assert
        XCTAssertNil(viewCell.icon.image)
    }
    
    func testThatCellHasConstraint() {
        // Arrange
        let viewCell = TableViewCell()
        // Act
        viewCell.updateConstraints()
        // Assert
        XCTAssertNotNil(viewCell.icon.constraints)
    }

}
