//
//  ViewModel.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import AVFoundation


protocol ScannerVCViewModelProtocol: AnyObject {
    var QRManager: QRScannableManagerProtocol? { get set }
    var view: ScannerViewInput? { get set }
    func viewDidChangeLifecycle(viewIsActive: Bool)
}


class ScannerVCViewModel: Coordinating {

    var coordinator: Coordinator?
    weak var view: ScannerViewInput?
    
    var QRManager: QRScannableManagerProtocol?
    var isViewActive: Bool = false
    
}

extension ScannerVCViewModel: QRScannableDelegate {
    func getSupportedCodeTypes() -> [AVMetadataObject.ObjectType] {
        [.qr]
    }
    
    func QRManager(didObtain rawData: String?, with barcodeFrame: CGRect?) {
        guard isViewActive else {
            return
        }
        
        view?.ScannerModel(self, didObtain: barcodeFrame)
        guard let rawData = rawData else {
            return
        }
        let decoder = MyJsonDecoder(with: rawData)
        guard let decodedData = decoder.parseJSON() else {
            return
        }
        isViewActive = false
        //call coordinator to send model to new VC
        coordinator?.eventOccured(with: .dataFetched(viewModel: decodedData))
    }
}

extension ScannerVCViewModel: ScannerVCViewModelProtocol {
    
    func viewDidChangeLifecycle(viewIsActive: Bool) {
        isViewActive = viewIsActive
    }
    
}
