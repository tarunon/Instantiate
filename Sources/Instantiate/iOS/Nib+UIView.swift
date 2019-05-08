//
//  Nib+UIView.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(iOS) || os(tvOS)
    
    import UIKit
    
    public extension NibInstantiatable where Self: UIView {
        init(with dependency:Dependency) {
            self = Self.nib.instantiate(withOwner: nil, options: nil)[Self.instantiateIndex] as! Self
            self.inject(dependency)
        }
    }
    
    public extension NibInstantiatableWrapper where Self: UIView, Wrapped: UIView {
        var view: Wrapped {
            return self.subviews.first as! Wrapped
        }
        
        var viewIfLoaded: Wrapped? {
            return self.subviews.first as? Wrapped
        }
        
        func loadView(with dependency:Wrapped.Dependency) {
            let view = Wrapped(with: dependency)
            if translatesAutoresizingMaskIntoConstraints {
                view.translatesAutoresizingMaskIntoConstraints = true
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view.frame = self.bounds
                self.insertSubview(view, at: 0)
            } else {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.insertSubview(view, at: 0)
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            }
        }
    }
    
#endif

