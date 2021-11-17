//
//  ItemsTableViewCell.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 14.11.2021.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        addDashedBottomBorder(to: self)
    }
    
    
    let companyLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let addressLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 1
        
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .right
        label.numberOfLines = 1
        
        return label
    }()
    
    
    private lazy var dateTimeStackView: UIStackView = {
        [dateLabel, timeLabel].toStackView(orientation: .horizontal, distribution: .fillEqually , spacing: 0)
    }()
    
    private lazy var mainStackView: UIStackView = {
        [companyLabel,addressLabel, dateTimeStackView].toStackView(orientation: .vertical, distribution: .fill, spacing: 5)
    }()
    
    private func setupUI(with data: [String: String]?) {
        contentView.backgroundColor = .clear
        addLabelText(with: data)
        addSubViews()
        setConstraints()
    }
    
    private func addLabelText(with data: [String: String]?) {
        timeLabel.text = data?["time"]
        dateLabel.text = data?["date"]
        companyLabel.text = data?["company"]
        addressLabel.text = data?["address"]
    }
    
    private func addSubViews() {
        contentView.addSubview(mainStackView)
    }
    private func setConstraints(){
        
        // autolayout constraint
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)        ])
    }
}




extension TitleTableViewCell {
    
    func setupLabelText(with data: [String: String]) {
        setupUI(with: data)
        sizeToFit()
    }
    
    func addDashedBottomBorder(to cell: UITableViewCell) {
        
        let color = UIColor.lightGray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = cell.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width - 20, height: 0)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [9,4]
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: shapeRect.height, width: shapeRect.width, height: 0), cornerRadius: 0).cgPath
        
        cell.layer.addSublayer(shapeLayer)
    }
    
}
