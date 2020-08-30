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

final class DetailPresenter {
    // MARK: - Cвойства
    var film: StarWars?
    var router: RouterProtocol?
    // MARK: - Приватные свойства
    weak var view: DetailViewProtocol?
    
    init(view: DetailViewProtocol, router: RouterProtocol, film: StarWars?) {
        self.view = view
        self.film = film
        self.router = router
    }
}

// MARK: - Реализация протокола
extension DetailPresenter: DetailViewPresenterProtocol {
    func setFilm() {
        self.view?.setFilm(film: film)
    }
    func tap() {
        router?.popToRoot()
    }
}
