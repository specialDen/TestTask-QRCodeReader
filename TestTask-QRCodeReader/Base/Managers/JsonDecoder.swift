//
//  JsonDecoder.swift
//  TestTask-QRCodeReader
//
//  Created by Izuchukwu Dennis on 13.11.2021.
//

import Foundation

class MyJsonDecoder {
    
    var jsonString: String
    var jsonData: Data
    
    init(with data: String){
        jsonString = data
        jsonData = jsonString.data(using: .utf8)!
    }
    
    public func parseJSON() -> AppModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AppModel.self, from: jsonData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
}
