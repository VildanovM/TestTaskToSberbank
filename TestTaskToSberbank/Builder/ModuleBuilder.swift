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

final class AssemblyModelBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UITableViewController {
        let view = MainTableViewController()
        let stackCoreData = StackCoreData()
        let networkService = NetworkService()
        let dataProvider = DataProvider(persistentContainer: stackCoreData.persistentContainer, repository: networkService as NetworkServiceProtocol)
        let presenter = MainPresenter(view: view, dataProvider: dataProvider as DataProviderProtocol, router: router)
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
