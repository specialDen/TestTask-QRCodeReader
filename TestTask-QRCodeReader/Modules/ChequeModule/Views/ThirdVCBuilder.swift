//
//  ThirdVCBuilder.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 14.11.2021.
//

import UIKit

struct ThirdVCBuilder {
    static func createThirdVC(appModel: AppModel, coordinator: Coordinator) -> ChequeViewController {
        let thirdVC = ChequeViewController()
        let viewModel = ThirdVCViewModel(with: appModel)
        let tableViewManager = TableViewManager()
        
        thirdVC.viewModel = viewModel
        viewModel.coordinator = coordinator
        viewModel.tableViewManager = tableViewManager
        viewModel.view = thirdVC
        
        tableViewManager.delegate = viewModel
        
        return thirdVC
    }
}
