//
//  Tips.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 30.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import Foundation

let dataErrorDomain = "Ошибка данных"

enum DataErrorCode: NSInteger {
    case networkUnavailable = 501
    case wrongDataFormat = 502
}
