//
//  JSONEncoder+Extension.swift
//
//  Created by Adriano Song on 7/8/19.
//

import Foundation

public extension JSONEncoder {
    
    func keyEncodingStrategy(strategy: KeyEncodingStrategy) -> JSONEncoder {
        self.keyEncodingStrategy = strategy
        return self
    }
}
