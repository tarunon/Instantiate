//
//  Identifier.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/04.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

/// Identifier type
public struct Identifier {
    public let rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension Identifier: ExpressibleByStringLiteral {
    public typealias UnicodeScalarLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = String
    public typealias StringLiteralType = String
    public init(stringLiteral value: String) {
        self.rawValue = value
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        self.rawValue = value
    }
    public init(unicodeScalarLiteral value: String) {
        self.rawValue = value
    }
}

public func +(lhs: Identifier, rhs: Identifier) -> Identifier {
    return Identifier(rawValue: lhs.rawValue + rhs.rawValue)
}
