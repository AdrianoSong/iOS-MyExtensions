//
//  NSTextAttachment+Extension.swift
//
//  Created by Adriano Song on 12/07/19.
//

import Foundation
import UIKit

public extension NSTextAttachment {
    ///Define image bounds (width and height) by size, (ex: size: 24) = 24x24
    func setImageBounds(size: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * size, height: size)
    }
}
