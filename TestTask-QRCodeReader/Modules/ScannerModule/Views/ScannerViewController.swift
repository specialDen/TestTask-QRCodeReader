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
    var subView: UIView?
    var decodedData: AppModel?
    var viewModel: (QRScannableDelegate & ScannerVCViewModelProtocol & Coordinating)?
    var leftImageView: UIImageView = UIImageView()
    var rightImageView: UIImageView = UIImageView()
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
        overrideUserInterfaceStyle = .light
        setupUI()
        captureSession.startRunning()
        //        startRunning2()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        viewModel?.viewDidChangeLifecycle(viewIsActive: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel?.viewDidChangeLifecycle(viewIsActive: true)
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        addSubViews()
        setConstraints()
        
        configuerLayout()
        configureVideoLayer(with: captureDevice)
    }

    
    @objc private func didTapFlash(){
        flashActive(on: captureDevice)
    }
    
    @objc private func didTapBackButton(){
        viewModel?.coordinator?.eventOccured(with: .dismiss)
            }
    
    private func addSubViews() {
        view.layer.addSublayer(videoPreviewLayer)
        guard let subView = createMaskingView() else{
            return
        }
        leftImageView = UIImageView(image: UIImage(named: Constants.leftNavBarImageName))
        rightImageView = UIImageView(image: UIImage(named: Constants.rightNavBarImageName))
        leftBarButton.addSubview(leftImageView)
        rightBarButton.addSubview(rightImageView)
        subView.addSubview(leftBarButton)
        subView.addSubview(rightBarButton)
        subView.addSubview(displayLabel)
        view.addSubview(subView)
        
        view.addSubview(qrCodeFrameView)
        view.bringSubviewToFront(qrCodeFrameView)
    }
    
    private func configuerLayout() {
        videoPreviewLayer.frame = view.bounds
    }
    
    let leftBarButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    let rightBarButton:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.addTarget(self, action: #selector(didTapFlash), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    let displayLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.text = Constants.ScannerVCLabelText
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    
    private func setConstraints() {
        let center = navigationController?.navigationBar.center
        leftBarButton.translatesAutoresizingMaskIntoConstraints = false
        rightBarButton.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.sizeToFit()
        
        NSLayoutConstraint.activate([

            leftBarButton.leftAnchor.constraint(equalTo: subView?.leftAnchor ?? view.leftAnchor, constant: 15),
            leftBarButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: (center?.y ?? 90)),

            
            rightBarButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: (center?.y ?? 90)),
            rightBarButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),

            
            displayLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: (center?.y ?? 90) + 120),
            displayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        leftImageView.frame = leftBarButton.bounds
        rightImageView.frame = rightBarButton.bounds
        
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

    func createMaskingView() -> UIView? {

        let overlay = UIView(frame: CGRect(x: 0, y: 0,
                                           width: UIScreen.main.bounds.width,
                                           height: UIScreen.main.bounds.height))
        
        // Set a semi-transparent, black background.
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        
        // Create the initial layer from the view bounds.
        let maskLayer = CAShapeLayer()
        maskLayer.frame = overlay.bounds
        maskLayer.fillColor = UIColor.black.cgColor
        
        // Create the frame for the inner rectangle.
        let innerRectPath = UIBezierPath(roundedRect: CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200), cornerRadius: 12)

        
        let path = UIBezierPath(rect: overlay.bounds)
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        path.append(innerRectPath)
        maskLayer.path = path.cgPath
        
        overlay.layer.mask = maskLayer
        
        return overlay

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
