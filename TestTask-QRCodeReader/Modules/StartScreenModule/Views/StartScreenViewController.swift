//
//  ViewController.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import UIKit

class StartScreenViewController: UIViewController, Coordinating {
    weak var coordinator: Coordinator?
    let subView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Оплата счёта"
        setupUI()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        use nslayoutts
        subView.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: view.frame.size.height-50)
        scanButton.frame = CGRect(x: 10, y: (7*subView.frame.size.height/8), width: subView.frame.size.width - 20, height: 70)
        displayLabel.frame = CGRect(x: 50, y: (3*subView.frame.size.height/10), width: subView.frame.size.width - 100, height: 200)
    }
    
    let scanButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        button.backgroundColor = .red
//        button.titleLabel?.text = "Сканировать"
        button.layer.cornerRadius = 12
        button.setTitle("Сканировать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapButton(){
        coordinator?.eventOccured(with: .scan)
        
    }
    
    let displayLabel:UILabel = {
        let label = UILabel()
        label.text = "Для оплаты заказа отсканйруете QR-код на чеке"
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



}

