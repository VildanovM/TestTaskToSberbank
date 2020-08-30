//
//  MainPresenter.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation
import CoreData

protocol MainViewPresenterProtocol: AnyObject {
    var dataProvider: DataProviderProtocol? { get set }
    func getFilms()
    func tapOnTheFilm(film: StarWars?)
    
}

class MainPresenter {
    
    // MARK: - Свойства
    var dataProvider: DataProviderProtocol?
    var router: RouterProtocol?
    // MARK: - weak Свойство
    weak var view: MainTableViewController?
    
    init(view: MainTableViewController?, dataProvider: DataProviderProtocol?, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.dataProvider = dataProvider
    }
    
    
}

// MARK: - Реализация протокола
extension MainPresenter: MainViewPresenterProtocol {
    
    func tapOnTheFilm(film: StarWars?) {
        router?.showDetail(film: film)
    }
    
    func getFilms() {
        guard let dataProvider = dataProvider else { return }
        dataProvider.fetchFilms { (error) in
            
        }
    }
    
}




