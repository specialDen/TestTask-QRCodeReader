//
//  TitleTableViewCell.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 14.11.2021.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {
    var undecodedData: String?
    
    var decodedData: AppModel?
    
    
    
    var companyLabelText: String = ""
    var addressLabelText:String = ""
    var dateLabelText:String = ""
    
    //    var items: [Item] = [Item(name: "roll", price: 32, count: 2), Item(name: "roll", price: 32, count: 2), Item(name: "roll", price: 32, count: 2)]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func layoutItems(with items: [Item]?){
        guard let items = items else {
            return
        }

        for item in items {
            setupRowView(with: item)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addDashedBottomBorder(to: self)
    }
    
    private func setupRowView(with item: Item){
        let itemLabel:UILabel = {
            let label = UILabel()
            label.text = "\(item.name) x " + String(format: "%.0f", item.count)
            label.font = .systemFont(ofSize: 18, weight: .bold)
            label.textColor = .black
            label.textAlignment = .left
            label.numberOfLines = 0
            return label
        }()
        
        let priceLabel:UILabel = {
            let label = UILabel()
            label.text = String(format: "%.2f", item.price) + " ₽"
            label.font = .systemFont(ofSize: 18, weight: .bold)
            label.textColor = .black
            label.textAlignment = .right
            label.numberOfLines = 0
            return label
        }()
        
        
        let itemStackView: UIStackView = {
            [itemLabel, priceLabel].toStackView(orientation: .horizontal, distribution: .fill , spacing: 0)
        }()
        
        mainStackView.addArrangedSubview(itemStackView)
    }

    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        addSubViews()
        setConstraints()
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
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
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




extension ItemsTableViewCell {
    func setupLabelText(with data: [Item]?) {
        layoutItems(with: data)
        sizeToFit()
    }
    
    
}



