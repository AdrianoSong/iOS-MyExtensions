//
//  UIImageView+Extension.swift
//
//  Created by Adriano Song on 01/04/20.
//

import Foundation
import UIKit
import AlamofireImage

public extension UIImageView {
    func setImage(url: String) {
        if let url = URL(string: url) {
            self.af.setImage(withURL: url)
        }
    }
}
