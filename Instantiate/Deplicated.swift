//
//  Deplicated.swift
//  Instantiate
//
//  Created by tarunon on 2017/04/01.
//  Copyright © 2017年 tarunon. All rights reserved.
//

import Foundation

public extension UITableView {
    @available(*, deprecated, message: "use 'C.dequeue(from:for:)' instead")
    public func dequeueReusableCell<C: UITableViewCell>(type: C.Type = C.self, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self, for: indexPath)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:for:with:)' instead")
    public func dequeueReusableCell<C: UITableViewCell>(type: C.Type = C.self, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, for: indexPath, with: parameter)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:)' instead")
    public func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type = C.self) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:with:)' instead")
    public func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type = C.self, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, with: parameter)
    }
}

public extension UICollectionView {
    @available(*, deprecated, message: "use 'C.dequeue(from:for:)' instead")
    public func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type = C.self, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self, for: indexPath)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:for:with:)' instead")
    public func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type = C.self, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, for: indexPath, with: parameter)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:of:for:)' instead")
    public func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type = C.self, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        return C.dequeue(from: self, of: kind, for: indexPath)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:of:for:with:)' instead")
    public func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type = C.self, of kind: String, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        return C.dequeue(from: self, of: kind, for: indexPath, with: parameter)
    }
}

public extension UITableView {
    @available(*, unavailable, message: "use 'C.dequeue(from:for:)' instead")
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:for:with:)' instead")
    public func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        fatalError()
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:)' instead")
    public func dequeReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type) -> C where C: Reusable, C.Parameter == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:with:)' instead")
    public func dequeReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type, with parameter: C.Parameter) -> C where C: Reusable {
        fatalError()
    }
}

public extension UICollectionView {
    @available(*, unavailable, message: "use 'C.dequeue(from:for:)' instead")
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:for:with:)' instead")
    public func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:of:for:)' instead")
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Parameter == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:of:for:with:)' instead")
    public func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath, with parameter: C.Parameter) -> C where C: Reusable {
        fatalError()
    }
}
