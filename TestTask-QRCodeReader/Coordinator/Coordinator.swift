//
//  Coordinator.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import UIKit

enum Events  {
    case scan
    case pay
    case dataFetched(viewModel: AppModel)
    case dismiss
}

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? {get set}
    func eventOccured(with type: Events)
    func start() 
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
}



