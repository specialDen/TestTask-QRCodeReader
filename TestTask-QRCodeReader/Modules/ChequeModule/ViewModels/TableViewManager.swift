//
//  TableViewManager.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 14.11.2021.
//

import UIKit

// Manager -> Delegate(ViewModel)
protocol TableViewManagerDelegate: AnyObject {

}

// Delegate -> Manager
protocol TableViewManagerProtocol {
    func setupTableView(using tableView: UITableView)
    func updateTableView(with decodeData: [String: String], items: [Item]?)
}


class TableViewManager: NSObject, UITableViewDataSource  {
    
    weak var delegate: TableViewManagerDelegate?
    var decodedData: [String: String]?
    var items: [Item]?
    weak var tableView: UITableView?
    
    override init() {
        super.init()
    }
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        } else {
//            return 40
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let useableData = decodedData else {
            return UITableViewCell()
        }
        var cell: UITableViewCell
     
        if indexPath.row == 0 {
            let titleCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.reuseIdentifier, for: indexPath) as! TitleTableViewCell
            titleCell.setupLabelText(with: useableData)
            cell = titleCell
        }else if indexPath.row == 1 {
            let itemsCell = tableView.dequeueReusableCell(withIdentifier: ItemsTableViewCell.reuseIdentifier, for: indexPath) as! ItemsTableViewCell
            itemsCell.setupLabelText(with: items)
            cell = itemsCell
        }else{
            let totalCell = tableView.dequeueReusableCell(withIdentifier: TotalTableViewCell.reuseIdentifier, for: indexPath) as! TotalTableViewCell
            totalCell.setupLabelText(with: useableData["total"])
            cell = totalCell
        }
//        cell.contentView.sizeToFit()
//        addDashedBottomBorder(to: cell)
        return cell
    }
    

      
}

extension TableViewManager: TableViewManagerProtocol {
    func setupTableView(using tableView: UITableView) {
        self.tableView = tableView
//        self.tableView?.sizeToFit()
        self.tableView?.dataSource = self
//        self.tableView?.delegate = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        tableView.register(ItemsTableViewCell.self, forCellReuseIdentifier: ItemsTableViewCell.reuseIdentifier)
        tableView.register(TotalTableViewCell.self, forCellReuseIdentifier: TotalTableViewCell.reuseIdentifier)
    }
    
    func updateTableView(with decodeData: [String: String], items: [Item]?) {
        self.decodedData = decodeData
        self.items = items
    }
    
    
}


