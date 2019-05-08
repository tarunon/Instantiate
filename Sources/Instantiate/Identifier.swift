//
//  Identifier.swift
//  Instantiate
//
//  Created by ST90872 on 2017/06/15.
//

import Foundation

public protocol IdentifierType {
    static func from(_ source: String) -> Self
}

extension String: IdentifierType {
    public static func from(_ source: String) -> String {
        return source
    }
}

extension IdentifierType where Self: RawRepresentable, Self.RawValue == String {
    public static func from(_ source: String) -> Self {
        return Self.init(rawValue: source)!
    }
}

#if os(macOS)
    import AppKit
    extension UserInterfaceItemIdentifier: IdentifierType {}
#endif
