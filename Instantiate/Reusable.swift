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

public extension Reusable where Self: UITableViewCell {
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with parameter: Parameter) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
        cell.bind(parameter)
        return cell
    }
}

public extension Reusable where Self: UITableViewCell, Self.Parameter == Void {
    public static func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return dequeue(from: tableView, for: indexPath, with: ())
    }
}

public extension Reusable where Self: UITableViewHeaderFooterView {
    public static func dequeue(from tableView: UITableView, with parameter: Parameter) -> Self {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.reusableIdentifier) as! Self
        view.bind(parameter)
        return view
    }
}

public extension Reusable where Self: UITableViewHeaderFooterView, Self.Parameter == Void {
    public static func dequeue(from tableView: UITableView) -> Self {
        return dequeue(from: tableView, with: ())
    }
}

public extension Reusable where Self: UICollectionViewCell {
    public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with parameter: Parameter) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
        cell.bind(parameter)
        return cell
    }
}

public extension Reusable where Self: UICollectionViewCell, Self.Parameter == Void {
    public static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return dequeue(from: collectionView, for: indexPath, with: ())
    }
}

public extension Reusable where Self: UICollectionReusableView {
    public static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath, with parameter: Parameter) -> Self {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
        view.bind(parameter)
        return view
    }
}

public extension Reusable where Self: UICollectionReusableView, Self.Parameter == Void {
    public static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath) -> Self {
        return dequeue(from: collectionView, of: kind, for: indexPath, with: ())
    }
}

public extension UITableView {
    public func register<C: UITableViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UITableViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueReusableCell<C: UITableViewCell>(type: C.Type = C.self, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self, for: indexPath)
    }
    
    public func dequeueReusableCell<C: UITableViewCell>(type: C.Type = C.self, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, for: indexPath, with: parameter)
    }
}

public extension UITableView {
    public func register<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable {
        register(C.self, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type = C.self) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self)
    }
    
    public func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type = C.self, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, with: parameter)
    }
}

public extension UICollectionView {
    public func register<C: UICollectionViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UICollectionViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type = C.self, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self, for: indexPath)
    }
    
    public func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type = C.self, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, for: indexPath, with: parameter)
    }
}

public extension UICollectionView {
    public func register<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable {
        register(C.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable, C: NibType {
        register(C.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type = C.self, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self, of: kind, for: indexPath)
    }
    
    public func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type = C.self, of kind: String, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, of: kind, for: indexPath, with: parameter)
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

