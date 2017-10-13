//
//  Implements.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/03.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
    
    import UIKit
    public typealias Nib = UINib
    public typealias NibName = String
    
#endif

#if os(macOS)
    
    import AppKit
    public typealias Nib = NSNib
    public typealias NibName = NSNib.Name
    
#endif

public protocol NibType {
    static var nibName: NibName { get }
    static var nibBundle: Bundle { get }
    static var nib: Nib { get }
}

public extension NibType where Self: NSObjectProtocol {
    static var nibBundle: Bundle {
        return Bundle(for: self)
    }

    static var nib: Nib {
        #if os(iOS) || os(tvOS)
            return Nib(nibName: nibName, bundle: nibBundle)
        #endif
        
        #if os(macOS)
            return Nib(nibNamed: nibName, bundle: nibBundle)!
        #endif
    }
}

/// Supports to associate View class and Nib.
/// Notes: `bind` call after `awakeFromNib`.
public protocol NibInstantiatable: Instantiatable, NibType {
    /// Index of `UINib.instantiate(withOwner:options:)`. Default is 0.
    static var instantiateIndex: Int { get }
}

public extension NibInstantiatable where Self: NSObject {
    static var instantiateIndex: Int {
        return 0
    }
}

/// Supports to use NibInstantiatable View class in other interface builder.(Nib or Storyboard)
/// Best practice is writing this implementations your NibInstantatable View class
/// ```
/// #if TARGET_INTERFACE_BUILDER
/// override func prepareForInterfaceBuilder() {
///     super.prepareForInterfaceBuilder()
///     loadView(with: self.dependency)
/// }
/// #else
/// required init?(coder aDecoder: NSCoder) {
///     super.init(coder: aDecoder)
///     loadView(with: self.dependency) // Maybe dependency is a computed property or Void.
/// }
/// #endif
/// ```
public protocol NibInstantiatableWrapper {
    associatedtype Wrapped: NibInstantiatable
    
    /// Wrapped NibInstantiatable View instance. It's safe after call `loadView`.
    var view: Wrapped { get }
    /// Wrapped NibInstantiatable View instance. Return nil if before call `loadView`.
    var viewIfLoaded: Wrapped? { get }
    
    /// Call this method on `init(coder:)` and `prepareForInterfaceBuilder`
    func loadView(with dependency:Wrapped.Dependency)
}

public extension NibInstantiatableWrapper where Wrapped.Dependency == Void {
    func loadView() {
        loadView(with: ())
    }
}

