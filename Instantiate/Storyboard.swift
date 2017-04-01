//
//  Storyboard.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/04.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

public protocol StoryboardType {
    static var storyboard: UIStoryboard { get }
}

public enum InstantiateSource {
    case initial
    case identifier(String)
}

/// Supports to associate ViewController class and Storyboard.
/// Notes: If you implement this class, your ViewController class load view in `instantiate(with:)`.
/// Notes: `bind` call after `viewDidLoad`.
public protocol StoryboardInstantiatable: Instantiatable, StoryboardType {
    /// Source of Storyboard identifier, or specify initial view controller. Default is .initial
    static var instantiateSource: InstantiateSource { get }
}

public extension StoryboardInstantiatable where Self: NSObject {
    static var instantiateSource: InstantiateSource {
        return .initial
    }
}

public extension StoryboardInstantiatable where Self: UIViewController {
    public static func instantiate(with dependency:Dependency) -> Self {
        let storyboard = (self as StoryboardType.Type).storyboard
        let _self: Self
        switch self.instantiateSource {
        case .initial:
            _self = storyboard.instantiateInitialViewController() as! Self
        case .identifier(let identifier):
            _self = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        }
        _ = _self.view // workaround: load view before bind.
        _self.inject(dependency)
        return _self
    }
}
