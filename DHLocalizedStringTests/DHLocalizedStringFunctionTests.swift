//
//  DHLocalizedStringFunctionTests.swift
//  DHLocalizedString
//
//  Created by Daniel Höpfl on 02.11.15.
//  Copyright © 2015 Daniel Höpfl. All rights reserved.
//

import XCTest
@testable import DHLocalizedString

class DHLocalizedStringFunctionTests: XCTestCase {
    let x = "String1"
    let y = "String2"
    let z = 42

    var alternativeBundle: NSBundle = NSBundle.mainBundle()

    override func setUp() {
        super.setUp()

        DHLocalizedStringStore.mainBundle = NSBundle(forClass: DHLocalizedStringFunctionTests.self);

        let path = DHLocalizedStringStore.mainBundle.resourcePath!
        alternativeBundle = NSBundle(path: path + "/DHLocalizedStringAlternative.bundle")!
    }

    func testSimpleExampleFromAlternativeFile() {
        let result = DHLocalizedString("Simple String", tableName: "Alternative")

        print("   Input: DHLocalizedString(\"Simple String\", tableName: \"Alternative\")")
        print("Expected: Translation of simple string (alternative file)")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Translation of simple string (alternative file)",
            result)
    }

    func testSimpleExampleFromAlternativeBundle() {
        let result = DHLocalizedString("Simple String", bundle: alternativeBundle)

        print("   Input: DHLocalizedString(\"Simple String\", bundle: alternativeBundle)")
        print("Expected: Translation in Alternative Bundle")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Translation in Alternative Bundle",
            result)
    }


    func testSimpleExampleFromAlternativeFileAndBundle() {
        let result = DHLocalizedString("Simple String", tableName: "Alternative", bundle: alternativeBundle)

        print("   Input: DHLocalizedString(\"Simple String\", tableName: \"Alternative\", bundle: alternativeBundle))")
        print("Expected: Translation in Alternative Bundle, Alternative file")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("Translation in Alternative Bundle, Alternative file",
            result)
    }

    func testSimpleExampleFromMainFileAndBundle() {
        let result = DHLocalizedString("Simple String")

        print("   Input: \"Simple String\" |~ ()")
        print("Expected: This is a translation of a simple string")
        print("  Result: \(result)")
        print("")

        XCTAssertEqual("This is a translation of a simple string",
            result)
    }

    func testArgumentsExampleFromAlternativeFile() {
        let result = DHLocalizedString("With sorting \(x), \(y), and \(z).", tableName: "Alternative")

        print("   Input: \"With sorting \\(x), \\(y), and \\(z).\" |~ \"Alternative\"")
        print("     Key: With sorting %1$@, %2$@, and %3$@.")
        print("Expected: end: 42, mid: String2, start: String1")
        print("  Result: \(result)")
        print("")
        
        XCTAssertEqual("end: 42, mid: String2, start: String1",
            result)
    }
}
