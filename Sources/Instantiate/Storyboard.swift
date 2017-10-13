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
    public typealias Storyboard = UIStoryboard
    public typealias StoryboardName = String
    public typealias StoryboardSceneIdentifier = String
#endif

#if os(macOS)
    
    import AppKit
    public typealias Storyboard = NSStoryboard
    public typealias StoryboardName = NSStoryboard.Name
    public typealias StoryboardSceneIdentifier = NSStoryboard.SceneIdentifier
#endif

public protocol StoryboardType {
    static var storyboardName: StoryboardName { get }
    static var storyboardBundle: Bundle { get }
    static var storyboard: Storyboard { get }
}

public extension StoryboardType where Self: NSObjectProtocol {
    static var storyboardBundle: Bundle {
        return Bundle(for: self)
    }
    
    static var storyboard: Storyboard {
        return Storyboard(name: storyboardName, bundle: storyboardBundle)
    }
}

public enum InstantiateSource {
    case initial
    case identifier(StoryboardSceneIdentifier)
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

