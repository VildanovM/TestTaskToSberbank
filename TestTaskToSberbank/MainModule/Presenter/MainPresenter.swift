//
//  MainPresenter.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation
import CoreData

protocol MainViewProtocol: AnyObject {
    
    func success()
    func failure(error: Error)
    
}

protocol MainViewPresenterProtocol: AnyObject {
    var dataProvider: DataProvider? { get set }
    func getFilms()
    var films: [StarWars]? { get set }
    func tapOnTheFilm(film: StarWars?)
    
}

class MainPresenter: MainViewPresenterProtocol {
    
    var dataProvider: DataProvider?
    
    
    
    var films: [StarWars]?
    var router: RouterProtocol?
    weak var view: MainViewProtocol?
    
    required init(view: MainViewProtocol, dataProvider: DataProvider, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.dataProvider = dataProvider
    }
    
    func tapOnTheFilm(film: StarWars?) {
        router?.showDetail(film: film)
    }
    
    func getFilms() {
        guard let dataProvider = dataProvider else { return }
        dataProvider.fetchFilms { (error) in
            // Handle Error by displaying it in UI
        }
    }
}




