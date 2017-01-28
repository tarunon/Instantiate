//
//  Reusable.swift
//  Instantiate
//
//  Created by tarunon on 2016/12/04.
//  Copyright © 2016年 tarunon. All rights reserved.
//

import Foundation

/// Implement your TableViewCell or CollectionViewCell or CollectionReusableView
public protocol Reusable {
    static var reusableIdentifier: Identifier { get }
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
    
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, indexPath: IndexPath, parameter: C.Parameter) -> C where C: Reusable, C: Bindable {
        let cell = dequeReusableCell(type: type, indexPath: indexPath)
        cell.bind(to: parameter)
        return cell
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
    
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable, C: Bindable {
        let cell = dequeReusableCell(type: type, for: indexPath)
        cell.bind(to: parameter)
        return cell
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
    
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable, C: Bindable {
        let view =  dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: C.reusableIdentifier.rawValue, for: indexPath) as! C
        view.bind(to: parameter)
        return view
    }
}

