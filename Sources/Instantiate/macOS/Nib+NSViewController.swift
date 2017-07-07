//
//  Nib+NSViewController.swift
//  Instantiate
//
//  Created by tarunon on 2017/07/07.
//
//

#if os(macOS)
    
    import AppKit
    
    public extension NibInstantiatable where Self: NSViewController {
        public init(with dependency: Dependency) {
            let nibName = (Self.self as NibType.Type).nibName
            let nibBundle = (Self.self as NibType.Type).nibBundle
            #if swift(>=4.0)
                self = Self(nibName: nibName, bundle: nibBundle)
            #else
                self = Self(nibName: nibName, bundle: nibBundle)!
            #endif
            if self is ViewLoadBeforeInject {
                _ = self.view
            }
            self.inject(dependency)
        }
    }

#endif
