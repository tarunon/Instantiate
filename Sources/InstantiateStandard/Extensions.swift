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
        public static var storyboard: UIStoryboard {
            return UIStoryboard(name: .from(self), bundle: bundle)
        }
    }

    public extension NibType where Self: NSObjectProtocol {
        public static var nib: UINib {
            return UINib(nibName: .from(self), bundle: bundle)
        }
    }
    
#endif

#if os(macOS)

    #if swift(>=4.0)
        extension NSStoryboard.Name: IdentifierType {}
        extension NSNib.Name: IdentifierType {}
    #endif
    
    import AppKit
    
    public extension StoryboardType where Self: NSObjectProtocol {
        public static var storyboard: NSStoryboard {
            return NSStoryboard(name: .from(self), bundle: bundle)
        }
    }
    
    public extension NibType where Self: NSObjectProtocol {
        public static var nib: NSNib {
            return NSNib(nibNamed: .from(self), bundle: bundle)!
        }
    }

#endif

public extension Reusable where Self: NSObjectProtocol {
    public static var reusableIdentifier: Instantiate.UserInterfaceItemIdentifier {
        return .from(self)
    }
}
