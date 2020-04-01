//
//  Realm+Extension.swift
//
//  Created by Adriano Song on 4/26/19.
//

import Foundation
import RealmSwift

public extension Realm {
    
    /// realm safe write on main thread
    func safeWrite(_ block: (@escaping () throws -> Void)) throws {
        
        DispatchQueue.main.async {
            try? autoreleasepool {
                if self.isInWriteTransaction {
                    try block()
                } else {
                    try self.write(block)
                }
            }
        }
    }
    
    /// realm safe write on main thread
    func safeWrite(_ block: (@escaping () throws -> Void), completion: (@escaping () -> Void)) throws {
        
        DispatchQueue.main.async {
            try? autoreleasepool {
                if self.isInWriteTransaction {
                    try block()
                } else {
                    try self.write(block)
                }
                
                completion()
            }
        }
    }
    
    /// realm safe write from any thread
    func backgroundSafeWrite(_ block: (@escaping () throws -> Void)) throws {
        
        DispatchQueue.global(qos: .background).async {
            try? autoreleasepool {
                if self.isInWriteTransaction {
                    try block()
                } else {
                    try self.write(block)
                }
            }
        }
    }
    
    /// realm safe write from any thread
    func backgroundSafeWrite(_ block: (@escaping () throws -> Void), completion: (@escaping () -> Void)) throws {
        
        DispatchQueue.global(qos: .background).async {
            try? autoreleasepool {
                if self.isInWriteTransaction {
                    try block()
                } else {
                    try self.write(block)
                }
                
                completion()
            }
        }
    }
}
