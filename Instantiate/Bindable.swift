//
//  Bindable.swift
//  Instantiate
//
//  Created by tarunon on 2017/01/28.
//  Copyright © 2017年 tarunon. All rights reserved.
//

import Foundation

public protocol Injectable {
    /// 'Parameter' will be unavailable, renamed Dependency
    associatedtype Parameter = Void
    associatedtype Dependency = Parameter
    func inject(_ dependency: Dependency)
    
    /// 'bind(_:)' will be unavailable, renamed 'inject(_:)'
    func bind(_ parameter: Dependency)
}

public extension Injectable where Dependency == Void {
    func inject(_ dependency: Dependency) {
        
    }
}
