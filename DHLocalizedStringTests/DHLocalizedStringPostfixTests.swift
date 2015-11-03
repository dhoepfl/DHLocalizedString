//
//  DHLocalizedStringPostfixTests.swift
//  DHLocalizedString
//
//  Created by Daniel Höpfl on 02.11.15.
//  Copyright © 2015 Daniel Höpfl. All rights reserved.
//

import XCTest
@testable import DHLocalizedString

class DHLocalizedStringPostfixTests: XCTestCase {
    let x = "String1"
    let y = "String2"
    let z = 42

    override func setUp() {
        super.setUp()

        DHLocalizedString.mainBundle = NSBundle(forClass: DHLocalizedStringPostfixTests.self);
    }

    func testSimpleExample() {
        let result = "Simple String"|~

        print("   Input: \"Simple String\"|~")
        print("     Key: Simple String")
        print("Expected: This is a translation of a simple string")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("This is a translation of a simple string",
            result)
    }

    func testWithArgumentsExample() {
        let result = "With arguments \(x), \(y), and \(z)."|~

        print("   Input: \"With arguments \\(x), \\(y), and \\(z).\"|~")
        print("     Key: With arguments %@, %@, and %@.")
        print("Expected: Translation with three arguments: [String1], [String2], and [42].")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Translation with three arguments: [String1], [String2], and [42].",
            result)
    }


    func testWithSortingExample() {
        let result = "With sorting \(x), \(y), and \(z)."|~

        print("   Input: \"With sorting \\(x), \\(y), and \\(z).\"|~")
        print("     Key: With sorting %@, %@, and %@.")
        print("Expected: Last: 42, First: String1, Second: String2")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Last: 42, First: String1, Second: String2",
            result)
    }
}
