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
#if os(macOS)
    import AppKit
    public typealias UserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier
#else
    public typealias UserInterfaceItemIdentifier = String
#endif
public protocol Reusable: Injectable {
    static var reusableIdentifier: UserInterfaceItemIdentifier { get }
}

