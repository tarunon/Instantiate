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
    public static func instantiate(with parameter: Parameter) -> Self {
        let _self = nib.instantiate(withOwner: nil, options: nil)[instantiateIndex] as! Self
        _self.bind(to: parameter)
        return _self
    }
}

/// Supports to use NibInstantiatable View class in other interface builder.(Nib or Storyboard)
/// Notes: if you call `loadView` in `awakeFromNib`, you cannot access `view` at `@IBOutlete { didSet }`. Need to wait parent class `viewDidLoad` or `awakeFromNib`. 
public protocol NibInstantiatableWrapper {
    associatedtype Wrapped: NibInstantiatable
    
    /// Wrapped NibInstantiatable View instance. It's safe after call `loadView`.
    var view: Wrapped { get }
    /// Wrapped NibInstantiatable View instance. Return nil if before call `loadView`.
    var viewIfLoaded: Wrapped? { get }
    
    /// Call this method on `awakeFromNib` and `prepareForInterfaceBuilder`
    func loadView(with parameter: Wrapped.Parameter)
}

public extension NibInstantiatableWrapper where Self: UIView, Wrapped: UIView {
    var view: Wrapped {
        return self.subviews.first as! Wrapped
    }
    
    var viewIfLoaded: Wrapped? {
        return self.subviews.first as? Wrapped
    }
    
    func loadView(with parameter: Wrapped.Parameter) {
        let view = Wrapped.instantiate(with: parameter)
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

public extension NibInstantiatableWrapper where Wrapped.Parameter == Void {
    func loadView() {
        loadView(with: ())
    }
}
