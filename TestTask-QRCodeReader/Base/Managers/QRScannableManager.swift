//
//  QRScannableManager.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 14.11.2021.
//

import Foundation
import AVFoundation

protocol QRScannableDelegate: AnyObject {
    func QRManager(didObtain rawData: String?, with barcodeFrame: CGRect?)
    func getSupportedCodeTypes() -> [AVMetadataObject.ObjectType]
}

protocol QRScannableManagerProtocol {
    func setupScanner(mediaOutPut: AVCaptureMetadataOutput, videoPlayerLayer: AVCaptureVideoPreviewLayer)
}

class QRScannableManager: NSObject {
    let supportedCodeTypes: [AVMetadataObject.ObjectType]
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private weak var delegate: QRScannableDelegate?
    
    init(
        delegate: QRScannableDelegate
    ) {
        self.delegate = delegate
        self.supportedCodeTypes = delegate.getSupportedCodeTypes()
        super.init()
    }
}

extension QRScannableManager: AVCaptureMetadataOutputObjectsDelegate {
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard
            let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject else {
                delegate?.QRManager(didObtain: nil, with: nil)
                return
            }

        if supportedCodeTypes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            delegate?.QRManager(didObtain: metadataObj.stringValue, with: barCodeObject?.bounds)
        }
    }
    
}

extension QRScannableManager: QRScannableManagerProtocol {
    func setupScanner(mediaOutPut: AVCaptureMetadataOutput, videoPlayerLayer: AVCaptureVideoPreviewLayer) {
        self.videoPreviewLayer = videoPlayerLayer
        mediaOutPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        mediaOutPut.metadataObjectTypes = supportedCodeTypes
    }
    
}
