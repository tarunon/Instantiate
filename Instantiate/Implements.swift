//
//  Implements.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/03.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}

public extension NibType where Self: NSObject {
    static var nib: UINib {
        return UINib(nibName: className, bundle: bundle)
    }
}

public extension NibInstantiatable where Self: NSObject {
    static var instantiateIndex: Int {
        return 0
    }
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

public extension NibInstantiatable where Self: UIView {
    public static func instantiate() -> Self {
        return nib.instantiate(withOwner: nil, options: nil)[instantiateIndex] as! Self
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

public extension Reusable where Self: UIView {
    static var identifier: Identifier {
        return Identifier(type: self)
    }
}

public extension UITableView {
    public func register<C: UITableViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellReuseIdentifier: C.reusableIdentifier.rawValue)
    }
    
    public func registerNib<C: UITableViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellReuseIdentifier: C.reusableIdentifier.rawValue)
    }
    
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, indexPath: IndexPath) -> C where C: Reusable {
        return dequeueReusableCell(withIdentifier: C.reusableIdentifier.rawValue, for: indexPath) as! C
    }
}

public extension UICollectionView {
    public func register<C: UICollectionViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellWithReuseIdentifier: C.reusableIdentifier.rawValue)
    }
    
    public func registerNib<C: UICollectionViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellWithReuseIdentifier: C.reusableIdentifier.rawValue)
    }
    
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable {
        return dequeueReusableCell(withReuseIdentifier: C.reusableIdentifier.rawValue, for: indexPath) as! C
    }
}

public extension UICollectionView {
    public func register<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable {
        register(C.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier.rawValue)
    }
    
    public func registerNib<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable, C: NibType {
        register(C.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier.rawValue)
    }
    
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath) -> C where C: Reusable {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: C.reusableIdentifier.rawValue, for: indexPath) as! C
    }
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
