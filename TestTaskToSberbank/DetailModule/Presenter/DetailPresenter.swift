//
//  DetailPresenter.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation
import CoreData

//protocol DetailViewProtocol: AnyObject {
//    func setComment(comment: Comment?)
//}
//
//protocol DetailViewPresenterProtocol: AnyObject {
//    
//    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?)
//    func setComment()
//    func tap()
//    
//}
//
//class DetailPresenter: DetailViewPresenterProtocol {
//    
//    var comment: Comment?
//    var router: RouterProtocol?
//    weak var view: DetailViewProtocol?
//    var dataProvider: DataProvider?
//    
//    
//    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?) {
//        self.view = view
//        self.networkService = networkService
//        self.comment = comment
//        self.router = router
//    }
//    
//    func tap() {
//        router?.popToRoot()
//    }
//    
//    func setFilms() {
//        self.view?.setComment(comment: comment)
//    }
//    
//    
//}
