//
//  TableViewExtension.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 16.11.2021.
//

import UIKit


extension UITableViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
