//
//  UseClassName.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/05.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

public protocol UseClassName: class {
}

extension UseClassName {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}

public extension Reusable where Self: UseClassName {
    static var reusableIdentifier: Identifier {
        return Identifier(type: self)
    }
}

public extension StoryboardType where Self: UseClassName{
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: className, bundle: bundle)
    }
}

public extension NibType where Self: UseClassName {
    static var nib: UINib {
        return UINib(nibName: className, bundle: bundle)
    }
}
