//
//  View+Extension.swift
//
//  Created by Adriano Song on 1/23/19.
//

import Foundation
import UIKit

public extension UIView {
    
    /// Prevent view constraint to pass the safeArea (top, bottom)
    var customLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide
        }
        
        let guide = UILayoutGuide()
        addLayoutGuide(guide)
        guide.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        guide.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        guide.topAnchor.constraint(equalTo: topAnchor).isActive = true
        guide.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return guide
    }
    
    static func fadeInAnimation(
        view: UIView?, duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: duration, animations: {
            view?.alpha = 1
            
        }, completion: { (_) in
            completion?()
        })
    }
    
    static func fadeOutAnimation(
        view: UIView?, duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: duration, animations: {
            view?.alpha = 0
            
        }, completion: { (_) in
            completion?()
        })
    }
    
    static func fadeInWindowCrossDissolveTransition(window: UIWindow,
                                                    duration: TimeInterval = 0.5,
                                                    viewController: UIViewController?,
                                                    completion: (() -> Void)? = nil) {
        
        UIView.transition(with: window,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: {
                            window.rootViewController = viewController
                            
        }, completion: { (_) in
            completion?()
        })
    }
    
    static func fadeInViewCrossDissolveTranstion(fromView: UIView,
                                                 duration: TimeInterval = 0.5,
                                                 toView: UIView,
                                                 completion: (() -> Void)? = nil) {
        
        UIView.transition(from: fromView,
                          to: toView,
                          duration: duration,
                          options: [.transitionCrossDissolve],
                          completion: { (_) in
                        completion?()
        })
    }
    
    static func yTranslationAnimation(
        viewToTranslate: UIView,
        duration: TimeInterval = 0.5,
        translationValue: CGFloat, completion: (() -> Void)? = nil) {
        
        UIView.animate(
            withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
                viewToTranslate.transform = CGAffineTransform(translationX: 0, y: translationValue)
            }, completion: { (_) in
                completion?()
        })
    }
}
