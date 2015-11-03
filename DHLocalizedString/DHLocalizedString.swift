//
//  DHLocalizedString.swift
//  DHLocalizedString
//
//  Created by Daniel Höpfl on 02.11.15.
//  Copyright © 2015 Daniel Höpfl. All rights reserved.
//

import Foundation

/**
 A helper class to localize any Swift string, including Swift strings that contain interpolations.

 - Usage: Use it by casting a string to `DHLocalizedString` or by calling the postfix operator `|~` on a Swift string.

 - Localized: An instance that has been localized.
 - Segment:   An instance that holds a segment of an interpolated string.
 */
enum DHLocalizedString : StringInterpolationConvertible, StringLiteralConvertible, CustomDebugStringConvertible, CustomStringConvertible {
    static var mainBundle = NSBundle.mainBundle()

    // case Localized(localizedString: String)
    case StringLiteral(literal: String, tableName: String?, bundle: NSBundle)
    case StringInterpolation(strings: [DHLocalizedString], tableName: String?, bundle: NSBundle)
    case Segment(data: Any)

    // StringLiteralConvertible

    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    typealias UnicodeScalarLiteralType = StringLiteralType

    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .StringLiteral(literal: "\(value)", tableName: nil, bundle: DHLocalizedString.mainBundle)
    }

    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .StringLiteral(literal: "\(value)", tableName: nil, bundle: DHLocalizedString.mainBundle)
    }

    init(stringLiteral value: StringLiteralType) {
        self = .StringLiteral(literal: "\(value)", tableName: nil, bundle: DHLocalizedString.mainBundle)
    }

    // StringInterpolationConvertible

    init(stringInterpolation strings: DHLocalizedString...) {
        self = .StringInterpolation(strings: strings, tableName: nil, bundle: DHLocalizedString.mainBundle)
    }

    init<T>(stringInterpolationSegment expr: T) {
        self = .Segment(data: expr)
    }

    // CustomStringConvertible

    var description: String {
        switch self {
        case StringLiteral(let string, let tableName, let bundle):
            return bundle.localizedStringForKey(string, value: nil, table: tableName)
        case StringInterpolation(let strings, let tableName, let bundle):
            var toggle = true
            let i18nString = strings.reduce("") {
                wholeString, part in

                toggle = !toggle
                if toggle {
                    return "\(wholeString)%@"
                } else {
                    return "\(wholeString)\(part.string)"
                }
            }
            toggle = true;
            let args = strings.filter({ (element) -> Bool in
                toggle = !toggle
                return toggle
            }).map { (argument) -> CVarArgType in
                return argument.string
            }
            let localizedString = withVaList(args) { (cvalistpointer) -> String in
                let format = bundle.localizedStringForKey(i18nString, value: nil, table: tableName)
                return NSString(format: format, arguments: cvalistpointer) as String
            }

            return localizedString
        case Segment(let data):
            return "\(data)"
        }
    }

    // CustomDebugStringConvertible

    var debugDescription: String {
        switch self {
        case StringLiteral(let string, let tableName, let bundle):
            return "[DHLocalizedString.StringLiteral(\(string), \(tableName), \(bundle)) -> \(self.description)]"
        case StringInterpolation(let strings, let tableName, let bundle):
            return "[DHLocalizedString.StringInterpolation(\(strings), \(tableName), \(bundle)) -> \(self.description)]"
        case Segment(let data):
            return "[DHLocalizedString.Segment(\(data)]"
        }
    }

    // Custom

    var string: String {
        switch self {
        case .StringLiteral(let literal, _, _):
            return literal
        case .StringInterpolation(let strings, _, _):
            return strings.reduce("", combine: { (complete, part) -> String in
                return "\(complete)\(part.string)"
            })
        case .Segment(let data):
            return "\(data)"
        }
    }
}

postfix operator |~ { }
postfix func |~ (value: DHLocalizedString) -> String {
    return value.description
}

infix operator |~ {}
func |~ (left: DHLocalizedString, bundle: (NSBundle)) -> String {
    switch left {
    case .StringLiteral(let literal, let tableName, _):
        return DHLocalizedString.StringLiteral(literal: literal, tableName: tableName, bundle: bundle).description
    case .StringInterpolation(let strings, let tableName, _):
        return DHLocalizedString.StringInterpolation(strings: strings, tableName: tableName, bundle: bundle).description
    case .Segment(_):
        return left.description
    }
}
func |~ (left: DHLocalizedString, tableNameAndBundle: (String, NSBundle)) -> String {
    let (tableName, bundle) = tableNameAndBundle

    switch left {
    case .StringLiteral(let literal, _, _):
        return DHLocalizedString.StringLiteral(literal: literal, tableName: tableName, bundle: bundle).description
    case .StringInterpolation(let strings, _, _):
        return DHLocalizedString.StringInterpolation(strings: strings, tableName: tableName, bundle: bundle).description
    case .Segment(_):
        return left.description
    }
}
func |~ (left: DHLocalizedString, tableName: (String)) -> String {
    switch left {
    case .StringLiteral(let literal, _, let bundle):
        return DHLocalizedString.StringLiteral(literal: literal, tableName: tableName, bundle: bundle).description
    case .StringInterpolation(let strings, _, let bundle):
        return DHLocalizedString.StringInterpolation(strings: strings, tableName: tableName, bundle: bundle).description
    case .Segment(_):
        return left.description
    }
}
func |~ (left: DHLocalizedString, rhs: Void) -> String {
    return left.description
}
