//
//  ModuleBuilder.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit
import CoreData

protocol AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UITableViewController
//    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController
    
    
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {

    func createMainModule(router: RouterProtocol) -> UITableViewController {
        
        let view = MainTableViewController()
        let persistentContainer = StackCoreData.shared.persistentContainer
        let dataProvider = DataProvider(persistentContainer: persistentContainer, repository: NetworkService.shared)
        
        let presenter = MainPresenter(view: view as MainViewProtocol, dataProvider: dataProvider, router: router)
        view.presenter = presenter
        
        return view
        
    }
    
//    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController {
//        let view = DetailViewController()
//        let networkService = NetworkService()
//        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
//        view.presenter = presenter
//
//        return view
//    }

}
