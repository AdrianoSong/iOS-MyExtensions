//
//  File.swift
//  
//
//  Created by Song on 24/09/20.
//

import Foundation

extension Float {
    /**
     Currency formatter
     
     - Parameter locale: `Locale`

     - Returns: `String`
     */
    func currencyFormatter(locale: Locale) -> String? {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currencyAccounting
        formatter.locale = locale
        
        return formatter.string(from: NSNumber(value: self))
    }
}
