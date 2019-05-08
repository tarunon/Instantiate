//
//  Nib+NSView.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(macOS)
    
    import AppKit
    
    public extension NibInstantiatable where Self: NSView {
        init(with dependency: Dependency) {
            var objects: NSArray? = NSArray()
            Self.nib.instantiate(withOwner: nil, topLevelObjects: &objects)
            self = objects!.filter { !($0 is NSApplication) }[Self.instantiateIndex] as! Self
            self.inject(dependency)
        }
    }
    
    public extension NibInstantiatableWrapper where Self: NSView, Wrapped: NSView {
        var view: Wrapped {
            return self.subviews.first as! Wrapped
        }
        
        var viewIfLoaded: Wrapped? {
            return self.subviews.first as? Wrapped
        }
        
        func loadView(with dependency: Wrapped.Dependency) {
            let view = Wrapped(with: dependency)
            if translatesAutoresizingMaskIntoConstraints {
                view.translatesAutoresizingMaskIntoConstraints = true
                view.autoresizingMask = [.width, .height]
                view.frame = self.bounds
                self.addSubview(view, positioned: .above, relativeTo: self.subviews.first)
            } else {
                view.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(view, positioned: .above, relativeTo: self.subviews.first)
                view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            }
        }
    }

#endif
