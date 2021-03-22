//
//  Array+Extension.swift
//
//  Created by Adriano Song on 4/2/19.
//

import Foundation

public extension Array {
    
    ///Get element before last on an array
    func penultimate() -> Element? {
        if self.count < 2 {
            return nil
        }
        let index = self.count - 2
        return self[index]
    }
}

public extension Array where Element: Equatable {
    
    /// Remove first collection element that is equal to the given `object`:
    mutating func remove(_ item: Element) {
        guard let index = firstIndex(of: item) else {return}
        remove(at: index)
    }
}
