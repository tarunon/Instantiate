//
//  Storyboard+NSViewController.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(macOS)
    
    import AppKit
    
    public extension StoryboardInstantiatable where Self: NSViewController {
        init(with dependency: Dependency) {
            let storyboard = (Self.self as StoryboardType.Type).storyboard
            switch Self.instantiateSource {
            case .initial:
                self = storyboard.instantiateInitialController() as! Self
            case .identifier(let identifier):
                self = storyboard.instantiateController(withIdentifier: identifier) as! Self
            }
            if self is ViewLoadBeforeInject {
                _ = self.view
            }
            self.inject(dependency)
        }
    }
    
#endif

