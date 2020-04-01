//
//  Int+Extension.swift
//
//  Created by Adriano Song on 2/27/19.
//

import Foundation

public extension Int {
    var ordinal: String? {
        let ordinalFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .ordinal
            return formatter
        }()
        
        return ordinalFormatter.string(from: NSNumber(value: self))
    }
    
    func numberOfWeeks() -> Int {
        let extraWeek = self % 7 > 0
        return self/7 + (extraWeek ? 1 : 0)
    }
}
