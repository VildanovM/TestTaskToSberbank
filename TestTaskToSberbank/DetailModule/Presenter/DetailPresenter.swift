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
    func configured()
    func returnToList()
}

final class DetailPresenter {
    // MARK: - Cвойства
    var film: StarWars?
    var router: RouterProtocol?
    // MARK: - Приватные свойства
    weak var view: DetailViewProtocol?
    
    init(router: RouterProtocol, film: StarWars?) {
        self.film = film
        self.router = router
    }
}

// MARK: - Реализация протокола
extension DetailPresenter: DetailViewPresenterProtocol {
    func configured() {
        self.view?.setFilm(film: film)
    }
    func returnToList() {
        router?.popToRoot()
    }
}
