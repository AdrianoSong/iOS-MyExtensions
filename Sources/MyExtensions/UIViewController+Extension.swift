//
//  ViewController+Extension.swift
//
//  Created by Adriano Song on 1/23/19.
//

import Foundation
import UIKit

public extension UIViewController {

    /// Prevent view constraint to pass the safeArea (top, bottom)
    var customLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide
        }

        let guide = UILayoutGuide()
        view.addLayoutGuide(guide)
        guide.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        guide.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        guide.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        guide.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return guide
    }

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
    
    /// Function for add notification behavior to open keyboard move all the screen up
    /// when close it, move all the screen down
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Removing keyboard notifications
      func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(
            self, name: UIResponder.keyboardWillHideNotification, object: nil)
      }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
