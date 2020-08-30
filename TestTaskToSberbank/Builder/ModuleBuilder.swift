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
    func createDetailModule(router: RouterProtocol, film: StarWars?) -> UIViewController
    
    
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
    
    func createDetailModule(router: RouterProtocol, film: StarWars?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view as DetailViewProtocol, router: router, film: film)
        view.presenter = presenter

        return view
    }

}
