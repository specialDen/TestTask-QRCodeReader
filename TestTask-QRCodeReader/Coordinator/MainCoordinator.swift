//
//  MainCoordinator.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import UIKit

class MainCordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccured(with type: Events) {
        
        switch type {
        case .scan:
            let scannerVC = ScannerVCBuilder.createScannerVC(coordinator: self)
            self.navigationController?.pushViewController(scannerVC , animated: true)
            
        case .pay:
            navigationController?.popToRootViewController(animated: true)
            //            navigationController?.pushViewController(vc, animated: true)
        case .dataFetched(viewModel: let appModel):
            let thirdVC = ChequeVCBuilder.createThirdVC(appModel: appModel, coordinator: self)
            navigationController?.pushViewController(thirdVC, animated: true)
        case .dismiss:
            navigationController?.popToRootViewController(animated: true)
            
        }
    }
    
    func start()  {
        
        let vc = StartScreenViewController()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor.red
    }
    
    
}

