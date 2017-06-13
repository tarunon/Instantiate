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

public func identifier(of type: NSObjectProtocol.Type) -> String {
    return type.className
}

#if os(iOS) || os(tvOS)
    
    import UIKit

    public extension StoryboardType where Self: NSObjectProtocol {
        public static var storyboard: UIStoryboard {
            return UIStoryboard(name: className, bundle: bundle)
        }
    }

    public extension NibType where Self: NSObjectProtocol {
        public static var nib: UINib {
            return UINib(nibName: className, bundle: bundle)
        }
    }
    
#endif

#if os(macOS)
    
    import Cocoa
    
    public extension StoryboardType where Self: NSObjectProtocol {
        public static var storyboard: NSStoryboard {
            return NSStoryboard(name: className, bundle: bundle)
        }
    }
    
    public extension NibType where Self: NSObjectProtocol {
        public static var nib: NSNib {
            return NSNib(nibNamed: className, bundle: bundle)!
        }
    }

#endif

public extension Reusable where Self: NSObjectProtocol {
    public static var reusableIdentifier: String {
        return identifier(of: self)
    }
}
