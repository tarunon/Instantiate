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
    public static func instantiate() -> Self {
        return nib.instantiate(withOwner: nil, options: nil)[instantiateIndex] as! Self
    }
}

/// Use this protocols implementation instead of NibInstantiatable in InterfaceBuilder.
public protocol NibInstantiatableWrapper {
    associatedtype Wrapped: NibInstantiatable
    var view: Wrapped { get }
    var viewIfLoaded: Wrapped? { get }
}

public extension NibInstantiatableWrapper where Self: UIView, Wrapped: UIView {
    var view: Wrapped {
        return self.subviews.first as! Wrapped
    }
    
    var viewIfLoaded: Wrapped? {
        return self.subviews.first as? Wrapped
    }
    
    /// Please call this method on `awakeFromNib()` and `prepareForInterfaceBuilder()` if needed.
    func loadViewFromNib(useAutolayout: Bool) {
        let view = Wrapped.instantiate()
        if useAutolayout {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.insertSubview(view, at: 0)
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        } else {
            view.translatesAutoresizingMaskIntoConstraints = true
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.frame = self.bounds
            self.insertSubview(view, at: 0)
        }
    }
}
