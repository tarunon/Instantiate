//
//  Instantiate.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/03.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

/// instantiate from Nib or Storyboard. Please implement it with NibInitializable or StoryboardInitializable.
public protocol Instantiatable: Bindable {
    static func instantiate(with parameter: Parameter) -> Self
}

public extension Instantiatable where Parameter == Void {
    static func instantiate() -> Self {
        return instantiate(with: ())
    }
}
