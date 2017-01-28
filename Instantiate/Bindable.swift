//
//  Bindable.swift
//  Instantiate
//
//  Created by tarunon on 2017/01/28.
//  Copyright © 2017年 tarunon. All rights reserved.
//

import Foundation

public protocol Bindable {
    associatedtype Parameter
    func bind(to parameter: Parameter)
}

public extension Bindable where Parameter == Void {
    func bind(to parameter: Parameter) {
        
    }
}
