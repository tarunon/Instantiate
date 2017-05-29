//
//  Implements.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/03.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

public protocol NibType {
    static var nib: UINib { get }
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

public extension NibInstantiatable where Self: UIView {    
    public init(with dependency:Dependency) {
        self = Self.nib.instantiate(withOwner: nil, options: nil)[Self.instantiateIndex] as! Self
        self.inject(dependency)
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

public extension NibInstantiatableWrapper where Self: UIView, Wrapped: UIView {
    var view: Wrapped {
        return self.subviews.first as! Wrapped
    }
    
    var viewIfLoaded: Wrapped? {
        return self.subviews.first as? Wrapped
    }
    
    func loadView(with dependency:Wrapped.Dependency) {
        let view = Wrapped(with: dependency)
        if translatesAutoresizingMaskIntoConstraints {
            view.translatesAutoresizingMaskIntoConstraints = true
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.frame = self.bounds
            self.insertSubview(view, at: 0)
        } else {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.insertSubview(view, at: 0)
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
    }
}

public extension NibInstantiatableWrapper where Wrapped.Dependency == Void {
    func loadView() {
        loadView(with: ())
    }
}
