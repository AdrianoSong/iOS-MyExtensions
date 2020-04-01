//
//  Data+Extension.swift
//
//  Created by Adriano Song on 3/19/19.
//

import Foundation

public extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
    
    var hex: String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
    
    func toEncodeJsonString() -> String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
}
