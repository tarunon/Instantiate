//
//  Nib+UIViewController.swift
//  Instantiate
//
//  Created by tarunon on 2017/07/07.
//
//

#if os(iOS) || os(tvOS)
    
    import UIKit
    
    public extension NibInstantiatable where Self: UIViewController {
        init(with dependency:Dependency) {
            let nibName = (Self.self as NibType.Type).nibName
            let nibBundle = (Self.self as NibType.Type).nibBundle
            self = Self(nibName: nibName, bundle: nibBundle)
            if self is ViewLoadBeforeInject {
                _ = self.view
            }
            self.inject(dependency)
        }
    }
    
#endif

