//
//  Storyboard+NSViewController.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(macOS)
    
    import Cocoa
    
    public extension StoryboardInstantiatable where Self: NSViewController {
        public init(with dependency: Dependency) {
            let storyboard = (Self.self as StoryboardType.Type).storyboard
            switch Self.instantiateSource {
            case .initial:
                self = storyboard.instantiateInitialController() as! Self
            case .identifier(let identifier):
                self = storyboard.instantiateController(withIdentifier: identifier) as! Self
            }
            _ = self.view // workaround: load view before inject.
            self.inject(dependency)
        }
    }
    
#endif

