//
//  Model.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import Foundation

struct AppModel: Codable {
    var order: Int
    var retailPoint: String
    var items: [Item]
    var address: String
    var date: String?
    var time: String?
    var total: String?
}

struct Item: Codable {
    var name: String
    var price: Double
    var count: Double
}

