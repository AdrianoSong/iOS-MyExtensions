//
//  Character+Extension.swift
//
//  Created by Adriano Song on 01/04/20.
//

import Foundation

public extension Character {
    func isEmoji() -> Bool {
        guard
            let unicode1 = UnicodeScalar(UInt32(0x1d000)),
            let unicode2 = UnicodeScalar(UInt32(0x1f77f)),
            let unicode3 = UnicodeScalar(UInt32(0x2100)),
            let unicode4 = UnicodeScalar(UInt32(0x26ff)) else { return false }
        
        return Character(unicode1) <= self && self <= Character(unicode2)
            || Character(unicode3) <= self && self <= Character(unicode4)
    }
}
