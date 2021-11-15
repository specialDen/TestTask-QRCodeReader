//
//  ScannerViewController.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import UIKit
import AVFoundation

protocol ScannerViewInput: AnyObject {
    func ScannerModel(_ model: ScannerVCViewModel, didObtain barcodeBounds: CGRect?)
}

class ScannerViewController: UIViewController  {
    var undecodedData: String?
    
    var decodedData: AppModel?
    var viewModel: (QRScannableDelegate & ScannerVCViewModelProtocol)?
//    = ScannerVCViewModel()

    private lazy var captureSession = AVCaptureSession()
    private lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer = {
        AVCaptureVideoPreviewLayer(session: captureSession)
    }()
    
    private let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    
    var qrCodeFrameView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.yellow.cgColor
        view.layer.borderWidth = 2
        
        return view
    }()
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        captureSession.startRunning()
//        startRunning2()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        leftBarButtonItem.action = #selector(didTapBackButton)

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.viewDidChangeLifecycle(viewIsActive: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.backgroundColor = .none
        viewModel?.viewDidChangeLifecycle(viewIsActive: true)
    }
    
    private func setupUI() {
       
        addSubViews()
//        ff()
        configuerLayout()
        configureVideoLayer(with: captureDevice)
        configureNavBar()
        
    }
    func configureNavBar(){
//        "nav-bar-back-button"
        navigationItem.title = ""
        navigationItem.leftBarButtonItems = [leftBarButtonItem]
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    let rightBarButtonItem: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(named: "nav-bar-back-button"), style: .plain, target: self, action: #selector(didTapFlash))
   
    }()
    
    lazy var leftBarButtonItem: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.title = "tfff"
        let image = UIImage(named: "nav-bar-back-button")
//        let imageView = UIImageView(image: image)
//        button.customView = imageView
        button.setBackgroundImage(image, for: .normal, barMetrics: .default)
//        imageView.frame =
//        image?.size = button.customView?.bounds.size ?? .equalTo(self)
//        button.target =
        button.action = #selector(didTapBackButton)

        
        return button
    }()
    
    @objc private func didTapFlash(){
        flashActive(on: captureDevice)
    }
    @objc private func didTapBackButton(){
        flashActive(on: captureDevice)
    }
    
    private func addSubViews() {
//        view.layer.addSublayer(videoPreviewLayer)
//        view.layer.addSublayer(ff())
//        view.addSubview(qrCodeFrameView)
//        view.bringSubviewToFront(qrCodeFrameView)
    }
    
    private func configuerLayout() {
        videoPreviewLayer.frame = view.bounds
    }
    
    private func configureVideoLayer(with device: AVCaptureDevice?) {
        guard let captureDevice = device else {
            print("Failed to get the camera device")
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            print(error.localizedDescription)
        }
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        viewModel?.QRManager?.setupScanner(mediaOutPut: captureMetadataOutput, videoPlayerLayer: videoPreviewLayer)
    }
    
    func flashActive(on device: AVCaptureDevice?) {
        guard let device = device, device.hasTorch else { return  }
            do {
                try device.lockForConfiguration()
                let torchOn = !device.isTorchActive
                try device.setTorchModeOn(level:1.0)
                device.torchMode = torchOn ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print("error")
            }
        
    }
//    deinit {
//        print("gtgtgtgrcrtvyjbukojyhtgr")
//    }
////    private func startRunning2() {
//
//    }
    
    
//    let radius: CGFloat = myRect.size.width
    func ff() -> CALayer{
    let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), cornerRadius: 0)
        let innerRectPath = UIBezierPath(roundedRect: CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200), cornerRadius: 12)
    path.append(innerRectPath)
    path.usesEvenOddFillRule = true

    let fillLayer = CAShapeLayer()
    fillLayer.path = path.cgPath
    fillLayer.fillRule = .evenOdd
        fillLayer.fillColor = UIColor.gray.cgColor
//view.backgroundColor?.cgColor
    fillLayer.opacity = 0.5
    return fillLayer
    }
    
    
}

extension ScannerViewController: ScannerViewInput {
    func ScannerModel(_ model: ScannerVCViewModel, didObtain barcodeBounds: CGRect?) {
        if let barcodeBounds = barcodeBounds {
            qrCodeFrameView.frame = barcodeBounds
            view.layoutIfNeeded()
        } else {
            qrCodeFrameView.frame = .zero
        }
    }
    
    
}
