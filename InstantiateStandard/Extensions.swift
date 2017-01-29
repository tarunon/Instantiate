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

public extension Reusable where Self: NSObjectProtocol {
    public static var reusableIdentifier: String {
        return identifier(of: self)
    }
}
