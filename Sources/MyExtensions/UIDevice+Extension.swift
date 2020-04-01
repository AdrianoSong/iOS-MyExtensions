//
//  UIDevice+Extension.swift
//
//  Created by Adriano Song on 1/16/19.
//

import Foundation
import UIKit

public extension UIDevice {
    func isIphone8() -> Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1334:
                return true
            default:
                return false
            }
        }
        return false
    }
}
