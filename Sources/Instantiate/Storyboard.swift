//
//  Storyboard.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/04.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    
    import UIKit
    public typealias Storybaord = UIStoryboard
    
#endif

#if os(macOS)
    
    import Cocoa
    public typealias Storybaord = NSStoryboard
    
#endif

public protocol StoryboardType {
    static var storyboard: Storybaord { get }
}

public enum InstantiateSource {
    case initial
    case identifier(String)
}

/// Supports to associate ViewController class and Storyboard.
/// Notes: If you implement this class, your ViewController class load view in `init(with:)`.
/// Notes: `inject` call after `viewDidLoad`.
public protocol StoryboardInstantiatable: Instantiatable, StoryboardType {
    /// Source of Storyboard identifier, or specify initial view controller. Default is .initial
    static var instantiateSource: InstantiateSource { get }
}

public extension StoryboardInstantiatable where Self: NSObject {
    static var instantiateSource: InstantiateSource {
        return .initial
    }
}

