//
//  MainCoordinator.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import UIKit

class MainCordinator: Coordinator {
    var navigationController: UINavigationController?
//    var delegate: CoordinatorDelegate?
    func eventOccured(with type: Events) {
        
        switch type {
        case .scan:
            var scannerVC = ScannerVCBuilder.createScannerVC(coordinator: self)
//            navigationController?.setViewControllers([navigationController!.viewControllers.first!, UIViewController()], animated: true)
            self.navigationController?.pushViewController(scannerVC , animated: true)
//            DispatchQueue.main.async {
//
//            }
            
        case .pay:
//            let vc = StartScreenViewController()
//            vc.coordinator = self
            navigationController?.popToRootViewController(animated: true)
//            navigationController?.pushViewController(vc, animated: true)
        case .dataFetched(viewModel: let appModel):
            let thirdVC = ThirdVCBuilder.createThirdVC(appModel: appModel, coordinator: self)
            navigationController?.pushViewController(thirdVC, animated: true)
        }
    }
    
    func start()  {
//        let items = [Item(name: "rice", price: 32000000000000, count: 1),Item(name: "fries", price: 132, count: 1), Item(name: "beans", price: 32, count: 3), Item(name: "fish", price: 32, count: 2)]
//        let appModel = AppModel(order: 12, retailPoint: "por", items: items, address: "31e fdsvv", date: "233", time: "12", total: "233")
        
        var vc = StartScreenViewController()
//        var viewModel: Coordinating = ScannerVCViewModel()
        vc.coordinator = self
        
        
        navigationController?.pushViewController(vc, animated: false)
//        return vc


//        navigationController?.navigationBar.backgroundColor = UIColor.red
//        navigationController?.navigationBar.barTintColor = UIColor.yellow

//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?
    }
    
    
}

