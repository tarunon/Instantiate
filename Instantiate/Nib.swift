//
//  Implements.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/03.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

public protocol NibType {
    static var nib: UINib { get }
}

public protocol NibInstantiatable: Instantiatable, NibType {
    static var instantiateIndex: Int { get }
}

public extension NibInstantiatable where Self: NSObject {
    static var instantiateIndex: Int {
        return 0
    }
}

public extension NibInstantiatable where Self: UIView {
    public static func instantiate() -> Self {
        return nib.instantiate(withOwner: nil, options: nil)[instantiateIndex] as! Self
    }
}
