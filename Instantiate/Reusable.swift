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
    
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeReusableCell(type: C.self, for: indexPath, with: ())
    }
    
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        let cell = dequeueReusableCell(withIdentifier: C.reusableIdentifier, for: indexPath) as! C
        cell.bind(parameter)
        return cell
    }
}

public extension UICollectionView {
    public func register<C: UICollectionViewCell>(type: C.Type) where C: Reusable {
        register(C.self, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
    
    public func registerNib<C: UICollectionViewCell>(type: C.Type) where C: Reusable, C: NibType {
        register(C.nib, forCellWithReuseIdentifier: C.reusableIdentifier)
    }
    
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeReusableCell(type: C.self, for: indexPath, with: ())
    }
    
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
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
    
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return dequeueReusableSupplementaryView(type: C.self, of: kind, for: indexPath, with: ())
    }
    
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: C.reusableIdentifier, for: indexPath) as! C
        view.bind(parameter)
        return view
    }
}

