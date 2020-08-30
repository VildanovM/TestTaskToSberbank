//
//  DetailPresenter.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation
import CoreData

protocol DetailViewProtocol: AnyObject {
    func setFilm(film: StarWars?)
}

protocol DetailViewPresenterProtocol: AnyObject {
    
    func setFilm()
    func tap()
    
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    func setFilm() {
        self.view?.setFilm(film: film)
    }
    
    
    
    var film: StarWars?
    var router: RouterProtocol?
    weak var view: DetailViewProtocol?
    var dataProvider: DataProvider?
    
    
    init(view: DetailViewProtocol, router: RouterProtocol, film: StarWars?) {
        self.view = view
        self.film = film
        self.router = router
    }
    
    func tap() {
        router?.popToRoot()
    }
    
    
}
