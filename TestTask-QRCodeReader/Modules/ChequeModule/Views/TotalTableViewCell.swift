//
//  TotalTableViewCell.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 14.11.2021.
//

import UIKit

class TotalTableViewCell: UITableViewCell {
    
    var decodedData: AppModel?
    
    
    var total: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI(with: total)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    private func setupRowView(with total: String?){
        let descriptionLabel:UILabel = {
            let label = UILabel()
            label.text = "К оплате:"
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.textColor = .black
            label.textAlignment = .left
            label.numberOfLines = 0
            return label
        }()
        
        let totalPriceLabel:UILabel = {
            let label = UILabel()
            label.text = total
            label.font = .systemFont(ofSize: 20, weight: .bold)
            label.textColor = .black
            label.textAlignment = .right
            label.numberOfLines = 0
            return label
        }()
        
        //
        //        let itemStackView: UIStackView = {
        //            [descriptionLabel, totalPriceLabel.toStackView(orientation: .horizontal, distribution: .fill , spacing: 0)
        //        }()
        
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.addArrangedSubview(totalPriceLabel)
    }
    
    
    //    private lazy var dateTimeStackView: UIStackView = {
    //        [dateLabel, timeLabel].toStackView(orientation: .horizontal, distribution: .fillEqually , spacing: 0)
    //    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private func setupUI(with total: String?) {
        contentView.backgroundColor = .clear
        setupRowView(with: total)
        addSubViews()
        setConstraints()
    }
    
    private func addSubViews() {
        contentView.addSubview(mainStackView)
        //        contentView.addSubview(stackView)
        
    }
    private func setConstraints(){
        
        // autolayout constraint
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)        ])
    }
}

extension TotalTableViewCell {
    func setupLabelText(with total: String?) {
        setupUI(with: total)
        sizeToFit()
    }
    
    
}
