//
//  Injectable.swift
//  Instantiate
//
//  Created by tarunon on 2017/01/28.
//  Copyright © 2017年 tarunon. All rights reserved.
//

import Foundation

public protocol Injectable {
    associatedtype Dependency = Void
    func inject(_ dependency: Dependency)
}

public extension Injectable where Dependency == Void {
    func inject(_ dependency: Dependency) {
        
    }
}
