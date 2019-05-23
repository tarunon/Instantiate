//
//  Extensions.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/05.
//  Copyright © 2016 tarunon. All rights reserved.
//

import Foundation
import Instantiate

extension NSObjectProtocol {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}

extension IdentifierType {
    public static func from(_ type: NSObjectProtocol.Type) -> Self {
        return Self.from(type.className)
    }
}

#if os(iOS) || os(tvOS)
    
    import UIKit

    public extension StoryboardType where Self: NSObjectProtocol {
        static var storyboardName: StoryboardName {
            return .from(self)
        }
    }

    public extension NibType where Self: NSObjectProtocol {
        static var nibName: NibName {
            return .from(self)
        }
    }
    
#endif

#if os(macOS)

    import AppKit
    
    public extension StoryboardType where Self: NSObjectProtocol {
        static var storyboardName: StoryboardName {
            return .from(self)
        }
    }
    
    public extension NibType where Self: NSObjectProtocol {
        static var nibName: NibName {
            return .from(self)
        }
    }

#endif

public extension Reusable where Self: NSObjectProtocol {
    static var reusableIdentifier: Instantiate.UserInterfaceItemIdentifier {
        return .from(self)
    }
}
