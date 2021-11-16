//
//  ThirdVCViewModel.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 14.11.2021.
//

import UIKit

//view -> ViewModel
protocol ChequeVCViewModelProtocol {
    var tableViewManager: TableViewManagerProtocol? { get set }

}


class ChequeVCViewModel: Coordinating {
    
    
    var coordinator: Coordinator?
    weak var view: ChequeVCViewInput?
    var tableViewManager: TableViewManagerProtocol?
    
//    private(set) var decodedData: AppModel?
    private var useableData = [String :String]()
    private var itemm: [Item]?

    
    init(with decodedData: AppModel) {
        self.useableData.updateValue("******" + "\t\t\(String(describing: decodedData.retailPoint))\t******", forKey: "company")
        self.useableData.updateValue(decodedData.address, forKey: "address")
        self.itemm = decodedData.items
        DispatchQueue.global().async {
            self.presentCellStrings()
        }
        
    }
    

    private func getTotal() -> String {
        guard let items = itemm ,itemm?.count != 0  else {
            return "0.00 ₽"
        }
        var total: Double = 0
        for item in items{
            let itemPrice = item.price * item.count
            total += itemPrice
        }
        let totalString = String(format: "%.2f", total) + " ₽"
        let totalForButton = totalString
        self.view?.setTotal(with: totalForButton)
        

        return totalString
    }
    
    private func presentCellStrings(){
        let date = Date().formatted(date: .numeric, time: .omitted).replacingOccurrences(of: "/", with: ".")
        useableData.updateValue(getTotal(), forKey: "total")
        useableData.updateValue(getTime(), forKey: "time")
        useableData.updateValue(date, forKey: "date")
        if !useableData.isEmpty{
            tableViewManager?.updateTableView(with: useableData, items: itemm)
        }
    }
    
    func getTime() -> String {
        let dateAsString = Date().formatted(date: .omitted, time: .shortened)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        
        let date = dateFormatter.date(from: dateAsString) ?? Date()
        dateFormatter.dateFormat = "HH:mm"
        
        let Date24 = dateFormatter.string(from: date )
        return Date24
        
    }
}


extension ChequeVCViewModel: ChequeVCViewModelProtocol {
    
}

extension ChequeVCViewModel: TableViewManagerDelegate {
    
}
