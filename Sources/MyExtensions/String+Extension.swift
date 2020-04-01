//
//  StringExtension.swift
//
//  Created by Adriano Song on 2/5/19.
//

import Foundation
import UIKit

public extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    static var validNumericValues = "0123456789."
    
    var weekDay: Date.Weekday {
        switch self.lowercased() {
        case "sunday":
            return .sunday
        case "monday":
            return .monday
        case "tuesday":
            return .tuesday
        case "wednesday":
            return .wednesday
        case "thursday":
            return .thursday
        case "friday":
            return .friday
        case "saturday":
            return .saturday
        default:
            return .monday
        }
    }
    
    func stringByRemovingEmoji() -> String {
        return String(self.filter { !$0.isEmoji() }).replacingOccurrences(of: "    ", with: "")
    }
    
    func numberByRemovingNonNumericCharacters() -> Int {
        guard let number = Int(self.filter(String.validNumericValues.contains)) else { return 0 }
        return number
    }
    
    func transformImageResourcesNameIntoAttribString(imageSize: CGFloat) -> NSAttributedString? {
        
        guard let image = UIImage(named: self) else {
            return nil
        }
        
        let textAttachment = NSTextAttachment()
        
        textAttachment.image = image
        textAttachment.setImageBounds(size: imageSize)
        
        return NSAttributedString(attachment: textAttachment)
    }
    
    func toAttributedString(fontSize: CGFloat) -> NSAttributedString {
        
        let fontAttrb = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        
        return NSAttributedString(string: self, attributes: fontAttrb)
    }
    
    func toDate(format: Date.Format) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: self)
    }
    
    /// Validates Password
    ///
    ///     Password should have at least 8 characters, upper case
    ///     and lower case letters, and one symbol
    ///
    /// - Parameter password: password string
    /// - Returns: true if password is valid
    var isValidPassword: Bool {
        guard !self.isEmpty else { return false }
        let regex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[\\W]).{8,}$"
        let matches = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return matches.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        guard !self.isEmpty else {
            return false
        }
        
        let entireRange = NSRange(location: 0, length: self.count)
        
        let types: NSTextCheckingResult.CheckingType = [.link]
        
        guard let detector = try? NSDataDetector(types: types.rawValue) else {
            return false
        }
        
        let matches = detector.matches(in: self, options: [], range: entireRange)
        
        // should only have a single match
        guard matches.count == 1 else {
            return false
        }
        
        guard let result = matches.first else {
            return false
        }
        
        // result should be a link
        guard result.resultType == .link else {
            return false
        }
        
        // result should be a recognized mail address
        guard result.url?.scheme == "mailto" else {
            return false
        }
        
        // match must be entire string
        guard NSEqualRanges(result.range, entireRange) else {
            return false
        }
        
        // but schould not have the mail URL scheme
        if self.hasPrefix("mailto:") {
            return false
        }
        
        // no complaints, string is valid email address
        return true
    }
    
    init(bundlePath: String) {
        self.init()
        let pathComponents = bundlePath.components(separatedBy: ":/")
        switch pathComponents[0] {
        case "bundle":
            if let resourcePath = Bundle.main.resourcePath {
                self = NSString(string: resourcePath).appendingPathComponent(pathComponents[1])
            }
        case "documents":
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask, true)[0]
            self = NSString(string: documentsPath).appendingPathComponent(pathComponents[1])
        case "cache":
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
            self = NSString(string: cachePath).appendingPathComponent(pathComponents[1])
        default:
            self = bundlePath
        }
    }
}
