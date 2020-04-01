//
//  ViewController+Extension.swift
//
//  Created by Adriano Song on 1/23/19.
//

import Foundation
import UIKit

public extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func addLoading(_ loadingController: UIViewController) {
        addChild(loadingController)
        view.addSubview(loadingController.view)
        
        loadingController.view.translatesAutoresizingMaskIntoConstraints = false
        loadingController.view.leftAnchor
            .constraint(equalTo: self.view.leftAnchor).isActive = true
        loadingController.view.rightAnchor
            .constraint(equalTo: self.view.rightAnchor).isActive = true
        loadingController.view.topAnchor
            .constraint(equalTo: self.view.topAnchor).isActive = true
        loadingController.view.bottomAnchor
            .constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        loadingController.didMove(toParent: self)
    }
    
    func safeRemove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
