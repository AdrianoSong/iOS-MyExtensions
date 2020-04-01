//
//  ArrayExtensionTests.swift
//  
//
//  Created by Adriano Song on 01/04/20.
//

import Foundation
import XCTest
@testable import MyExtensions

class ArrayExtensionTests: XCTestCase {
    
    static var allTests = [
        ("testSamples", testSamples),
    ]
    
    func penultimateTest(value: [Int], expected: Int) {
        
        XCTAssertEqual(value.penultimate(), expected)
    }
    
    func testSamples() {
        penultimateTest(value: [1, 2, 3, 4, 5], expected: 4)
    }
}
