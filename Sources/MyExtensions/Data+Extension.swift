//
//  Data+Extension.swift
//
//  Created by Adriano Song on 3/19/19.
//

import Foundation
import CommonCrypto

public extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
    
    var hex: String {
        return self.reduce("") { string, byte in
            string + String(format: "%02X", byte)
        }
    }
    
    func toEncodeJsonString() -> String? {
        return String(data: self, encoding: String.Encoding.utf8)
    }
    
    /// Function for convert Data to SHA256 cryptography algorithm
    /// - Returns: a converted Data to String value
    func toSha256() -> String {
        /// RSA header values that is append to the cryptography algorithm
        let rsa2048Asn1Header: [UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]
        
        var keyWithHeader = Data(rsa2048Asn1Header)
        
        keyWithHeader.append(self)
        
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        keyWithHeader.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(keyWithHeader.count), &hash)
        }
        
        return Data(hash).base64EncodedString()
    }
}
