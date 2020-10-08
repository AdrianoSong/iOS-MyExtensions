//
//  UIApplication+Extension.swift
//  
//  Created by Song on 18/09/20.
//

import Foundation
import UIKit

public extension UIApplication {
    /// extension for dismiss keyboard (howToUse: UIApplication.shared.endEditing())
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
