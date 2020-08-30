//
//  Router.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(film: StarWars?)
    func popToRoot()
}

class Router {
    
    // MARK: - Свойства
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    
    
    
}

// MARK: - Реализация протокола

extension Router: RouterProtocol {
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
        
    }
    
    func showDetail(film: StarWars?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(router: self, film: film) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
