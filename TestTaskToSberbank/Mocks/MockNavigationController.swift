//
//  MockNavigationController.swift
//  TestTaskToSberbankTests
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
    var presentedVC : UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
