//
//  Instantiate.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/03.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

/// instantiate from Nib or Storyboard. Please implement it with NibInitializable or StoryboardInitializable.
public protocol Instantiatable {
    static func instantiate() -> Self
}
