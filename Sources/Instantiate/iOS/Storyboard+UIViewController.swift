//
//  Storyboard+UIViewController.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(iOS) || os(tvOS)
    
    import UIKit
    
    public extension StoryboardInstantiatable where Self: UIViewController {
        init(with dependency:Dependency) {
            let storyboard = (Self.self as StoryboardType.Type).storyboard
            switch Self.instantiateSource {
            case .initial:
                self = storyboard.instantiateInitialViewController() as! Self
            case .identifier(let identifier):
                self = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
            }
            if self is ViewLoadBeforeInject {
                _ = self.view
            }
            self.inject(dependency)
        }
    }
    
#endif

