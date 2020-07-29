//
//  View+Extension.swift
//
//  Created by Adriano Song on 1/23/19.
//

import Foundation
import UIKit

public extension UIView {

    enum ShadowType {
        case full, bottomOval, bottomRectangle
    }

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

    ///variadic function to add views into one view (like viewcontroller)
    func addSubviews(_ views: UIView...) {
        views.forEach{addSubview($0)}
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

    /**
     Apply custom shadow to your view

     Example how to use:

     myView.applyShadow(type: .full, shadowColor: .green, shadowRadius: 10, opacity: 0.8)

     myView.applyShadow(type: .bottomRectangle)

     myView.applyShadow(type: .bottomOval, shadowHeight: 5, ovalHeight: 10)

     - Parameter type: `ShadowType` (full, bottomOval, bottomRectangle).
     - Parameter view: `UIView` the view that will receive the shadow.
     - Parameter shadowColor: `UIColor`
     - Parameter shadowRadius: `CGFloat`
     - Parameter shadowHeight: `CGFloat`
     - Parameter ovalHeight: `CGFloat`
     - Parameter opacity: `Float`

     - Returns: `Void`
    */
    func applyShadow(type: ShadowType = .full,
                     shadowColor: UIColor = .black,
                     shadowRadius: CGFloat = 3,
                     shadowHeight: CGFloat = 20,
                     ovalHeight: CGFloat = 30,
                     opacity: Float = 0.5) {
        self.layoutIfNeeded() //force update layout

        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: self.bounds.maxY + shadowHeight)
        self.layer.shadowRadius = shadowRadius

        var ovalRect = self.bounds
        ovalRect.size.height = ovalHeight

        switch type {
        case .full:
            self.layer.shadowOffset = .zero
        case .bottomOval:
            self.layer.shadowPath = UIBezierPath(ovalIn: ovalRect).cgPath
        case .bottomRectangle:
            self.layer.shadowPath = UIBezierPath(roundedRect: ovalRect, cornerRadius: 3).cgPath
        }
    }

    /**
     Apply custom rounded corners to your view

     Example how to use:

     myView.applyRoundedCorners(corners: [.layerMinXMinYCorner], radius: 12) //apply at top left corner

     - Parameter corners: `CACornerMask` array of corners [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner].
     - Parameter radius: `CGFloat` corner radius.

     - Returns: `Void`
    */
    func applyRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }

    /**
     Apply custom border to your view

     Example how to use:

     myView.applyBorder(strokeColor: .black, lineWidth: 5) // simple usage

     - Parameter lineDashPattern: `[NSNumber]?` array of numbers, with each value representing an empty or a filled segment (ex: [30, 15] 30 units filled, 15 units unfilled), value nil represent a solid line
     - Parameter lineCap: `CAShapeLayerLineCap` represent the end of each dash segment.
     - Parameter lineJoin: `CAShapeLayerLineJoin` represent the appearance of each join.
     - Parameter strokeColor: `UIColor` represent the border color.
     - Parameter lineWidth: `UIColor` represent the border width.

     - Returns: `Void`
    */
    func applyBorder(
        lineDashPattern: [NSNumber]? = nil,
        lineCap: CAShapeLayerLineCap = .square,
        lineJoin: CAShapeLayerLineJoin = .miter,
        strokeColor: UIColor,
        lineWidth: CGFloat) {

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = UIBezierPath(rect: layer.bounds).cgPath
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.fillColor = backgroundColor?.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.lineCap = lineCap
        shapeLayer.lineJoin = lineJoin

        layer.addSublayer(shapeLayer)
    }
}
