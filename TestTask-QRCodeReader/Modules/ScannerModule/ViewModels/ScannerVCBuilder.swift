//
//  ScannerVCBuilder.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 15.11.2021.
//

import UIKit

struct ScannerVCBuilder {
    static func createScannerVC(coordinator: Coordinator) -> ScannerViewController {
        let scannerVC = ScannerViewController()
        let viewModel = ScannerVCViewModel()
        let scannerVCManager = QRScannableManager(delegate: viewModel)
        
        viewModel.QRManager = scannerVCManager
        scannerVC.viewModel = viewModel
        viewModel.coordinator = coordinator
        viewModel.view = scannerVC

        return scannerVC
    }
}
