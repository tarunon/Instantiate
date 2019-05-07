//
//  Deprecated.swift
//  Instantiate
//
//  Created by tarunon on 2017/04/01.
//  Copyright © 2017年 tarunon. All rights reserved.
//

import Foundation

@available(*, unavailable, renamed: "Injectable", message: "'Bindable' is now unavailable, please check 'Injectable'")
public protocol Bindable: Injectable {
    associatedtype Parameter = Dependency
}

public extension Injectable {
    @available(*, unavailable, renamed: "inject")
    func bind(_ parameter: Dependency) {
        inject(parameter)
    }
}

#if os(iOS)
    
import UIKit

public extension UITableView {
    @available(*, deprecated, message: "use 'C.dequeue(from:for:)' instead")
    func dequeueReusableCell<C: UITableViewCell>(type: C.Type = C.self, for indexPath: IndexPath) -> C where C: Reusable, C.Dependency == Void {
        return C.dequeue(from: self, for: indexPath)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:for:with:)' instead")
    func dequeueReusableCell<C: UITableViewCell>(type: C.Type = C.self, for indexPath: IndexPath, with dependency:C.Dependency) -> C where C: Reusable {
        return C.dequeue(from: self, for: indexPath, with: dependency)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:)' instead")
    func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type = C.self) -> C where C: Reusable, C.Dependency == Void {
        return C.dequeue(from: self)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:with:)' instead")
    func dequeueReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type = C.self, with dependency:C.Dependency) -> C where C: Reusable {
        return C.dequeue(from: self, with: dependency)
    }
}

public extension UICollectionView {
    @available(*, deprecated, message: "use 'C.dequeue(from:for:)' instead")
    func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type = C.self, for indexPath: IndexPath) -> C where C: Reusable, C.Dependency == Void {
        return C.dequeue(from: self, for: indexPath)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:for:with:)' instead")
    func dequeueReusableCell<C: UICollectionViewCell>(type: C.Type = C.self, for indexPath: IndexPath, with dependency:C.Dependency) -> C where C: Reusable {
        return C.dequeue(from: self, for: indexPath, with: dependency)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:of:for:)' instead")
    func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type = C.self, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Dependency == Void {
        return C.dequeue(from: self, of: kind, for: indexPath)
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:of:for:with:)' instead")
    func dequeueueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type = C.self, of kind: String, for indexPath: IndexPath, with dependency:C.Dependency) -> C where C: Reusable {
        return C.dequeue(from: self, of: kind, for: indexPath, with: dependency)
    }
}

public extension UITableView {
    @available(*, unavailable, message: "use 'C.dequeue(from:for:)' instead")
    func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Dependency == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:for:with:)' instead")
    func dequeReusableCell<C: UITableViewCell>(type: C.Type, for indexPath: IndexPath, with dependency:C.Dependency) -> C where C: Reusable {
        fatalError()
    }
    
    @available(*, deprecated, message: "use 'C.dequeue(from:)' instead")
    func dequeReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type) -> C where C: Reusable, C.Dependency == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:with:)' instead")
    func dequeReusableHeaderFooter<C: UITableViewHeaderFooterView>(type: C.Type, with dependency:C.Dependency) -> C where C: Reusable {
        fatalError()
    }
}

public extension UICollectionView {
    @available(*, unavailable, message: "use 'C.dequeue(from:for:)' instead")
    func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath) -> C where C: Reusable, C.Dependency == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:for:with:)' instead")
    func dequeReusableCell<C: UICollectionViewCell>(type: C.Type, for indexPath: IndexPath, with dependency:C.Dependency) -> C where C: Reusable {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:of:for:)' instead")
    func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath) -> C where C: Reusable, C.Dependency == Void {
        fatalError()
    }
    
    @available(*, unavailable, message: "use 'C.dequeue(from:of:for:with:)' instead")
    func dequeueReusableSupplementaryView<C: UICollectionReusableView>(type: C.Type, of kind: String, for indexPath: IndexPath, with dependency:C.Dependency) -> C where C: Reusable {
        fatalError()
    }
}

#endif
