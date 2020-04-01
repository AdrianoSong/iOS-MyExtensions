//
//  Encodable+Extension.swift
//
//  Created by Adriano Song on 3/6/19.
//

import Foundation

public extension Encodable {
    
    var dictionary: [String: Any]? {
       return try? self.asDictionary()
    }
    
    var dictionaryArray: [[String: Any]?] {
    
        guard let array = self as? [Codable] else {
            return [[:]]
        }
        
        var parsedMap : [[String: Any]?] = [[:]]
        
        array.forEach { element in
            parsedMap.append(try? element.asDictionary())
        }
        
        return parsedMap
        
    }

    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization
            .jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
