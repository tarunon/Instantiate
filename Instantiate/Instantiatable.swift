//
//  Instantiate.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/03.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

/// `init(with:)` make user interface object with Nib/Storyboard and some parameter(s) using `Injectable` protocol.
public protocol Instantiatable: Injectable {
    init(with dependency:Dependency)
}

public extension Instantiatable {
    static func instantiate(with dependency: Dependency) -> Self {
        return Self(with: dependency)
    }
}

public extension Instantiatable where Dependency == Void {
    static func instantiate() -> Self {
        return Self(with: ())
    }
}
