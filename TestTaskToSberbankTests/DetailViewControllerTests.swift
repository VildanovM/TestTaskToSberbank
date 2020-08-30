//
//  DetailViewControllerTest.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import XCTest

class DetailViewControllerTests: XCTestCase {
    
    func testThatDetailViewControllerMakePop() {
        //Arrange
        let navigationVC = MockNavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let detailViewController = DetailViewController()
        let router = Router(navigationController: navigationVC, assemblyBuilder: assemblyBuilder)
        let detailPresenter = DetailPresenter(router: router, film: StarWars(producer: "Foo", title: "Bar", director: "Foo", openingCrawl: "Baz", episodeId: 3, releaseDate: "Bar"))
        detailViewController.presenter = detailPresenter
        //Act
        detailViewController.popToBackAction()
        //Assert
        XCTAssertNil(router.navigationController?.viewControllers.first as? MainTableViewController)
    }
    
    func testThatDetailViewControllerMakeSetup() {
        //Arrange
        let navigationVC = MockNavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let detailViewController = DetailViewController()
        let router = Router(navigationController: navigationVC, assemblyBuilder: assemblyBuilder)
        let detailPresenter = DetailPresenter(router: router, film: StarWars(producer: "Foo", title: "Bar", director: "Foo", openingCrawl: "Baz", episodeId: 3, releaseDate: "Bar"))
        detailViewController.presenter = detailPresenter
        //Act
        detailViewController.setFilm(film: StarWars(producer: "Foo", title: "Bar", director: "Foo", openingCrawl: "Baz", episodeId: 3, releaseDate: "Bar"))
        guard let text = detailViewController.producerLabel.text else { return }
        //Assert
        XCTAssertTrue(text.contains("Foo"))
    }
    
    func testThatDetailPresenterHasConfigurate() {
        //Arrange
        let navigationVC = MockNavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let detailViewController = DetailViewController()
        let router = Router(navigationController: navigationVC, assemblyBuilder: assemblyBuilder)
        let detailPresenter = DetailPresenter(router: router, film: StarWars(producer: "Foo", title: "Bar", director: "Foo", openingCrawl: "Baz", episodeId: 3, releaseDate: "Bar"))
        detailViewController.presenter = detailPresenter
        //Act
        detailPresenter.configured()
        //Assert
        XCTAssertNil(router.navigationController?.viewControllers.first as? MainTableViewController)
    }
    
    func testThatDetailViewControllerHasALabels() {
        //Arrange
        let detailViewController = DetailViewController()
        //Act
        detailViewController.viewWillAppear(true)
        let arrayOfViewsAlpha = [detailViewController.titleLabel.alpha, detailViewController.producerLabel.alpha, detailViewController.directorLabel.alpha, detailViewController.releaseDateLabel.alpha, detailViewController.filmImage.alpha]
        //Assert
        XCTAssertFalse(arrayOfViewsAlpha.contains(0))
    }
    
    func testThatDetailViewControllerHasStackViewConstraints() {
        //Arrange
        let detailViewController = DetailViewController()
        //Act
        detailViewController.viewDidLoad()
        //Assert
        XCTAssertNotNil(detailViewController.stackView.constraints)
    }

}
