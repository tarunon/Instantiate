//
//  Reusable+NSTableView.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(macOS)

    import AppKit
    
    public extension Reusable where Self: NSView {
        static func dequeue(from tableView: NSTableView, with dependency: Dependency) -> Self {
            let view = tableView.makeView(withIdentifier: Self.reusableIdentifier, owner: nil) as! Self
            view.inject(dependency)
            return view
        }
    }
    
    public extension Reusable where Self: NSView, Dependency == Void {
        static func dequeue(from tableView: NSTableView) -> Self {
            return dequeue(from: tableView, with: ())
        }
    }
    
    public extension NSTableView {
        func registerNib<C: NSView>(type: C.Type) where C: Reusable, C: NibType {
            register(C.nib, forIdentifier: C.reusableIdentifier)
        }
    }

#endif
