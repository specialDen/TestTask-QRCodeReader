//
//  ThirdVC.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import UIKit

// Protocol -> View
protocol ThirdVCViewInput: AnyObject {
    func setTotal(with total: String)
}

class ChequeViewController: UIViewController {
    // Protocol for VC -> ViewModel
    var viewModel: (ThirdVCViewModelProtocol & Coordinating)?
    var subView = UIView()
    private let tableView = UITableView()

    init() {
        super.init(nibName: nil, bundle: nil)
//        subView = UIView(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: view.frame.size.height - 50))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewmodel.delegate = self
        overrideUserInterfaceStyle = .light
        title = "Оплата счёта"
        view.backgroundColor = .red
        navigationController?.navigationBar.backgroundColor = .red
        navigationController?.navigationItem.rightBarButtonItem?.image = UIImage(named: "nav-bar-flash-button")
        subView.backgroundColor = .lightGray
        addSubViews()
        setConstraints()

//        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        
        viewModel?.tableViewManager?.setupTableView(using: tableView)
//        print(getTimet())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //        use nslayoutts
//        payButton.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 20, height: 70)
        tableView.frame = CGRect(x: 10, y: (2*view.frame.size.height/8), width: view.frame.size.width - 20, height: 330)
//        setConstraints()
//        payButton.frame.size.height = 200
    }
    
    private func addSubViews(){

        view.addSubview(subView)
        payButton.addSubview(amountLabel)
        subView.addSubview(payButton)
        subView.addSubview(tableView)
    }
    private func setConstraints() {
        subView.frame = CGRect(x: 0, y: 50, width: view.frame.size.width, height: view.frame.size.height - 50)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.sizeToFit()
        tableView.sizeToFit()
//        payButton.frame.size.height = 70
        NSLayoutConstraint.activate([
            
//            tableView.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -10),
//            tableView.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 10),
//            tableView.centerYAnchor.constraint(equalTo: subView.centerYAnchor, constant: -75),
            
//            amountLabel.topAnchor.constraint(equalTo: payButton.topAnchor)
            amountLabel.rightAnchor.constraint(equalTo: payButton.rightAnchor, constant: -10),
            amountLabel.centerYAnchor.constraint(equalTo: payButton.centerYAnchor),
//            amountLabel.heightAnchor.constraint(equalTo: 70)
            
            payButton.topAnchor.constraint(equalTo: subView.topAnchor, constant: subView.frame.size.height - 105),
            payButton.leftAnchor.constraint(equalTo: subView.leftAnchor, constant: 10),
            payButton.rightAnchor.constraint(equalTo: subView.rightAnchor, constant: -10),
            payButton.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -35)
            
            
        ])
    }
    

                         
    let payButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 200))
        button.backgroundColor = .red
//        button.titleLabel?.text = "Сканировать"
        button.layer.cornerRadius = 12
        button.setTitle("Оплатить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        button.addSubview(a)
        return button
    }()
    
    let amountLabel:UILabel = {
        let label = UILabel()
//        label.text = "\(item.name) x \(item.count)"
//        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    
    
    @objc private func didTapButton(){
        viewModel?.coordinator?.eventOccured(with: .pay)
    }


}


extension ChequeViewController: ThirdVCViewInput {
    func setTotal(with total: String) {
        DispatchQueue.main.async {
            self.amountLabel.text = total
        }
        
    }
    
    
}
