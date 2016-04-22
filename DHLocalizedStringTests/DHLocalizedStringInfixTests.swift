//
//  DHLocalizedStringInfixTests.swift
//  DHLocalizedString
//
//  Created by Daniel Höpfl on 02.11.15.
//  Copyright © 2015 Daniel Höpfl. All rights reserved.
//

import XCTest
@testable import DHLocalizedString

class DHLocalizedStringInfixTests: XCTestCase {
    let x = "String1"
    let y = "String2"
    let z = 42

    var alternativeBundle: NSBundle = NSBundle.mainBundle()

    override func setUp() {
        super.setUp()

        DHLocalizedStringStore.mainBundle = NSBundle(forClass: DHLocalizedStringInfixTests.self);

        let path = DHLocalizedStringStore.mainBundle.resourcePath!
        alternativeBundle = NSBundle(path: path + "/DHLocalizedStringAlternative.bundle")!
    }

    func testSimpleExampleFromAlternativeFile() {
        let result = "Simple String" |~ "Alternative"

        print("   Input: \"Simple String\" |~ \"Alternative\"")
        print("Expected: Translation of simple string (alternative file)")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Translation of simple string (alternative file)",
            result)
    }

    func testSimpleExampleFromAlternativeBundle() {
        let result = "Simple String" |~ alternativeBundle

        print("   Input: \"Simple String\" |~ alternativeBundle")
        print("Expected: Translation in Alternative Bundle")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Translation in Alternative Bundle",
            result)
    }


    func testSimpleExampleFromAlternativeFileAndBundle() {
        let result = "Simple String" |~ ("Alternative", alternativeBundle)

        print("   Input: \"Simple String\" |~ (\"Alternative\", alternativeBundle)")
        print("Expected: Translation in Alternative Bundle, Alternative file")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Translation in Alternative Bundle, Alternative file",
            result)
    }

    func testSimpleExampleFromMainFileAndBundle() {
        let result = "Simple String" |~ ()

        print("   Input: \"Simple String\" |~ ()")
        print("Expected: This is a translation of a simple string")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("This is a translation of a simple string",
            result)
    }

    func testArgumentsExampleFromAlternativeFile() {
        let result = "With sorting \(x), \(y), and \(z)." |~ "Alternative"

        print("   Input: \"With sorting \\(x), \\(y), and \\(z).\" |~ \"Alternative\"")
        print("     Key: With sorting %1$@, %2$@, and %3$@.")
        print("Expected: end: 42, mid: String2, start: String1")
        print("  Result: \(result)")
        print("")
        
        XCTAssertEqual("end: 42, mid: String2, start: String1",
            result)
    }
}
