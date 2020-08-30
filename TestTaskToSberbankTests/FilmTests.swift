//
//  FilmTests.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 31.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest

class FilmTests: XCTestCase {


    func testThatCreateUpdate() {
        //Arrange
        let film = Film()
        
        //Act, Assert
        XCTAssertThrowsError(try film.update(with: ["director":"Foo"]))
        
    }
    
    

}
