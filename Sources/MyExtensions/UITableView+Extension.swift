//
//  File.swift
//  
//
//  Created by Song on 31/05/20.
//

import Foundation
import UIKit

extension UITableView {
    ///Fade inout to reloadData() into a UITableView
    func fadeReloadData(duration: TimeInterval = 0.35) {
        UIView.transition(
            with: self, duration: duration, options: .curveEaseIn, animations: { [weak self] in
            self?.alpha = 0

        }, completion: { _ in
            UIView.transition(
                with: self, duration: 0.35, options: .curveEaseOut, animations: { [weak self] in
                self?.alpha = 1
                self?.reloadData()
            })
        })
    }
}
