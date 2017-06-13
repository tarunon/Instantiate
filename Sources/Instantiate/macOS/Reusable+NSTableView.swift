//
//  Reusable+NSTableView.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(macOS)

    import Cocoa
    
    public extension Reusable where Self: NSView {
        public static func dequeue(from tableView: NSTableView, with dependency: Dependency) -> Self {
            let view = tableView.make(withIdentifier: Self.reusableIdentifier, owner: nil) as! Self
            view.inject(dependency)
            return view
        }
    }
    
    public extension Reusable where Self: NSView, Dependency == Void {
        public static func dequeue(from tableView: NSTableView) -> Self {
            return dequeue(from: tableView, with: ())
        }
    }
    
    public extension NSTableView {
        public func registerNib<C: NSView>(type: C.Type) where C: Reusable, C: NibType {
            register(C.nib, forIdentifier: C.reusableIdentifier)
        }
    }

#endif
