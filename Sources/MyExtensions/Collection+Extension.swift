//
//  Collection+Extension.swift
//
//  Created by Adriano Song on 08/05/19.
//

import Foundation

public extension Collection {
    ///safe access to collection
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
