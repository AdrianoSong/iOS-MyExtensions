//
//  TextField+Extension.swift
//
//  Created by Adriano Song on 2/4/19.
//

import Foundation
import UIKit

public extension UITextField {
    
    func underlined(frameWidth: CGFloat, color: CGColor) {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color
        border.frame = CGRect(x: 0,
                              y: 80 - width,
                              width: frameWidth,
                              height: 1)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
