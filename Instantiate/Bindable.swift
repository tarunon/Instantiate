//
//  Bindable.swift
//  Instantiate
//
//  Created by tarunon on 2017/01/28.
//  Copyright © 2017年 tarunon. All rights reserved.
//

import Foundation

/// User Interface bind some parameter(s).
public protocol Bindable {
    associatedtype Parameter
    /// `bind` call after prepare user intarfaces. e.g.) `UIViewController.viewDidLoad`, `UIView.awakeFromNib`.
    /// - parameter parameter: User interface needs to some parameter(s).
    func bind(_ parameter: Parameter)
}

public extension Bindable where Parameter == Void {
    func bind(_ parameter: Parameter) {
        
    }
}
