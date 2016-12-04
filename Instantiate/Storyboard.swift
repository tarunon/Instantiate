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
    case identifier(Identifier)
}

public protocol StoryboardInstantiatable: Instantiatable, StoryboardType {
    static var instantiateSource: InstantiateSource { get }
}

public extension StoryboardType where Self: NSObject {
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: className, bundle: bundle)
    }
}

public extension StoryboardInstantiatable where Self: NSObject {
    static var instantiateSource: InstantiateSource {
        return .initial
    }
}

public extension StoryboardInstantiatable where Self: UIViewController {
    public static func instantiate() -> Self {
        let _self = self as StoryboardInstantiatable.Type
        switch _self.instantiateSource {
        case .initial:
            return _self.storyboard.instantiateInitialViewController() as! Self
        case .identifier(let identifier):
            return _self.storyboard.instantiateViewController(withIdentifier: identifier.rawValue) as! Self
        }
    }
}
