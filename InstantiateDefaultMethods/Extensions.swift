//
//  Extensions.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/05.
//  Copyright © 2016年 tarunon. All rights reserved.
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

extension Identifier {
    init(type: NSObjectProtocol.Type) {
        self.rawValue = type.className
    }
}

extension StoryboardType where Self: NSObjectProtocol {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: className, bundle: bundle)
    }
}

extension NibType where Self: NSObjectProtocol {
    static var nib: UINib {
        return UINib(nibName: className, bundle: bundle)
    }
}

extension SegueSource where Self: UIViewController {
    public func segue<V: UIViewController>(type: V.Type) -> Segue<V> where V: NSObjectProtocol {
        return self.segue(type: V.self, identifier: Identifier(type: V.self))
    }
}
