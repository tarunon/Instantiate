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

/// Implement your TableViewCell or CollectionViewCell or CollectionReusableView
public protocol Reusable {
    static var reusableIdentifier: Identifier { get }
}

public protocol NibType {
    static var nib: UINib { get }
}

public protocol NibInstantiatable: Instantiatable, NibType {
    static var instantiateIndex: Int { get }
}

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

/// Typed segue identifier
public protocol SegueType {
    associatedtype Destination: UIViewController
    var identifier: Identifier { get }
    func destination(from segue: UIStoryboardSegue) -> Destination
}

/// Implement this protocol on ViewController and call `_prepare(for:)` on `override func prepare(for:)`
public protocol SegueSource: class {
    var handlers: [String: (UIViewController) -> ()] { get set }
    func register<S: SegueType>(for segue: S, prepare: @escaping (S.Destination) -> ())
    func remove<S: SegueType>(segue: S)
    func perform<S: SegueType>(segue: S, prepare: @escaping (S.Destination) -> ())
}
