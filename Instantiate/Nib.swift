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

public protocol NibInstantiatable: Instantiatable, NibType {
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

/// Use this protocols implementation instead of NibInstantiatable in InterfaceBuilder.
public protocol NibInstantiatableWrapper {
    associatedtype Wrapped: NibInstantiatable
    
    var view: Wrapped { get }
    var viewIfLoaded: Wrapped? { get }
    
    /// Call this method on `awakeFromNib` and `prepareForInterfaceBuilder`
    func loadView(with parameter: Wrapped.Parameter, autolayoutEnabled: Bool)
}

public extension NibInstantiatableWrapper where Self: UIView, Wrapped: UIView {
    var view: Wrapped {
        return self.subviews.first as! Wrapped
    }
    
    var viewIfLoaded: Wrapped? {
        return self.subviews.first as? Wrapped
    }
    
    func loadView(with parameter: Wrapped.Parameter, autolayoutEnabled: Bool) {
        let view = Wrapped.instantiate(with: parameter)
        if autolayoutEnabled {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.insertSubview(view, at: 0)
            view.addConstraints(
                [
                    view.topAnchor.constraint(equalTo: self.topAnchor),
                    view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    view.leftAnchor.constraint(equalTo: self.leftAnchor),
                    view.rightAnchor.constraint(equalTo: self.rightAnchor)
                ]
            )
        } else {
            view.translatesAutoresizingMaskIntoConstraints = true
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.frame = self.bounds
            self.insertSubview(view, at: 0)
        }
    }
}

public extension NibInstantiatableWrapper where Wrapped.Parameter == Void {
    func loadView(autolayoutEnabled: Bool) {
        loadView(with: (), autolayoutEnabled: autolayoutEnabled)
    }
}
