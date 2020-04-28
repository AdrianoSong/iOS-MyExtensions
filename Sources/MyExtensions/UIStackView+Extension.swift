//
//  File.swift
//  
//
//  Created by Song on 28/04/20.
//

import Foundation
import UIKit

public extension UIStackView {

    ///variadic function to add views into stackview
    func addArrangeSubviews(_ views: UIView...) {
        views.forEach{addArrangedSubview($0)}
    }
}
