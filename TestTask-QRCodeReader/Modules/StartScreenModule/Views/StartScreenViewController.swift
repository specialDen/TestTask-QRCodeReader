//
//  ViewController.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import UIKit
import AVFoundation

class StartScreenViewController: UIViewController, Coordinating {
    weak var coordinator: Coordinator?
    let subView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        title = Constants.title
        setupUI()
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        subView.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: view.frame.size.height-50)
        scanButton.frame = CGRect(x: 10, y: (7*subView.frame.size.height/8), width: subView.frame.size.width - 20, height: 70)
        displayLabel.frame = CGRect(x: 50, y: (3*subView.frame.size.height/10), width: subView.frame.size.width - 100, height: 200)
    }
    
    let scanButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        button.backgroundColor = .red
        button.layer.cornerRadius = 12
        button.setTitle(Constants.scanButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapButton(){
//        check if user granted access to camera
        guard AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized else {
            handleUserNotAuthorized()
            return
        }
        coordinator?.eventOccured(with: .scan)
    }
    
    let displayLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.startScreenLabelText
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    private func setupUI() {
        view.backgroundColor = .red
        subView.backgroundColor = .white
        addSubViews()
        
    }
    private func addSubViews(){
        view.addSubview(subView)
        view.addSubview(scanButton)
        subView.addSubview(displayLabel)
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: Constants.alertTitle, message: Constants.alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTitle, style: .default) {[weak self] _ in
            self?.goToAppSettings()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func goToAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func handleUserNotAuthorized(){
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { [weak self] (granted: Bool) -> Void in
            DispatchQueue.main.async {
                guard granted else {
                    self?.presentAlert()
                    return
                }
                self?.coordinator?.eventOccured(with: .scan)
            }
        })
    }

}

