//
//  Segue.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/04.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

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

/// Standard Segue
public struct Segue<V: UIViewController>: SegueType {
    public typealias Destination = V
    public var identifier: Identifier
}

public extension SegueType {
    public func destination(from segue: UIStoryboardSegue) -> Destination {
        return segue.destination as! Destination
    }
}

public extension SegueSource where Self: UIViewController {
    /// Please override UIViewController.prepare(for:) and call this function
    public func _prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
            let handler = handlers[identifier] else {
                return
        }
        handler(segue.destination)
    }
    
    public func segue<V: UIViewController>(type: V.Type, identifier: Identifier=Identifier(type: V.self)) -> Segue<V> {
        return Segue<V>(identifier: identifier)
    }
    
    public func register<S: SegueType>(for segue: S, prepare: @escaping (S.Destination) -> ()) {
        handlers[segue.identifier.rawValue] = { (viewController) in
            prepare(viewController as! S.Destination)
        }
    }
    
    public func remove<S: SegueType>(segue: S) {
        handlers.removeValue(forKey: segue.identifier.rawValue)
    }
    
    public func perform<S: SegueType>(segue: S, prepare: @escaping (S.Destination) -> ()) {
        register(for: segue, prepare: prepare)
        performSegue(withIdentifier: segue.identifier.rawValue, sender: self)
        remove(segue: segue)
    }
}
