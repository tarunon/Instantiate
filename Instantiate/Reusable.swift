//
//  Reusable.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/04.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

/// Supports UITableView/UICollectionView reusable features.
/// Implement your UITableViewCell/UICollectionViewCell subclass.
public protocol Reusable: Bindable {
    static var reusableIdentifier: String { get }
}

public extension UITableView {
    public func register<C: UITableViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UITableViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeueReusableCell(type: C.self, for: indexPath, with: ())
    }
    
    public func dequeueReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        let cell = dequeueReusableCell(withIdentifier: C.reusableIdentifier, for: indexPath) as! C
        cell.bind(parameter)
        return cell
    }
}

public extension UITableView {
    public func register<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable {
        register(C.self, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type) -> C where C: Reusable, C.Parameter == Void {
        return dequeueReusableHeaderFooter(type: C.self, with: ())
    }
    
    public func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type, with parameter: C.Parameter) -> C where C: Reusable {
        let view = dequeueReusableHeaderFooterView(withIdentifier: C.reusableIdentifier) as! C
        view.bind(parameter)
        return view
    }
}

public extension UICollectionView {
    public func register<C: UICollectionViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UICollectionViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeueReusableCell(type: C.self, for: indexPath, with: ())
    }
    
    public func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        let cell = dequeueReusableCell(withReuseIdentifier: C.reusableIdentifier, for: indexPath) as! C
        cell.bind(parameter)
        return cell
    }
}

public extension UICollectionView {
    public func register<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable {
        register(C.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable, C: NibType {
        register(C.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeueueReusableSupplementaryView(type: C.self, of: kind, for: indexPath, with: ())
    }
    
    public func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: C.reusableIdentifier, for: indexPath) as! C
        view.bind(parameter)
        return view
    }
}

// unavailable renamed methods
public extension UITableView {
    @available(*, unavailable, renamed: "dequeueReusableCell")
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeueReusableCell(type: C.self, for: indexPath)
    }
    
    @available(*, unavailable, renamed: "dequeueReusableCell")
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return dequeueReusableCell(type: C.self, for: indexPath, with: parameter)
    }
    
    @available(*, unavailable, renamed: "dequeueReusableHeaderFooter")
    public func dequeReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type) -> C where C: Reusable, C.Parameter == Void {
        return dequeueReusableHeaderFooter(type: C.self)
    }
    
    @available(*, unavailable, renamed: "dequeueReusableHeaderFooter")
    public func dequeReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type, with parameter: C.Parameter) -> C where C: Reusable {
        return dequeueReusableHeaderFooter(type: C.self, with: parameter)
    }
}

public extension UICollectionView {
    @available(*, unavailable, renamed: "dequeueReusableCell")
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeueReusableCell(type: C.self, for: indexPath)
    }
    
    @available(*, unavailable, renamed: "dequeueReusableCell")
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return dequeueReusableCell(type: C.self, for: indexPath, with: parameter)
    }
    
    @available(*, unavailable, renamed: "dequeueueReusableSupplementaryView")
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeueueReusableSupplementaryView(type: C.self, of: kind, for: indexPath)
    }
    
    @available(*, unavailable, renamed: "dequeueueReusableSupplementaryView")
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return dequeueueReusableSupplementaryView(type: C.self, of: kind, for: indexPath, with: parameter)
    }
}

