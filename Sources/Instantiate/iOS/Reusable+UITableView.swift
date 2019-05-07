//
//  Reusable+UITableView.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(iOS) || os(tvOS)
    
    import UIKit
    
    public extension Reusable where Self: UITableViewCell {
        static func dequeue(from tableView: UITableView, for indexPath: IndexPath, with dependency:Dependency) -> Self {
            let cell = tableView.dequeueReusableCell(withIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
            cell.inject(dependency)
            return cell
        }
    }
    
    public extension Reusable where Self: UITableViewCell, Self.Dependency == Void {
        static func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
            return dequeue(from: tableView, for: indexPath, with: ())
        }
    }
    
    public extension Reusable where Self: UITableViewHeaderFooterView {
        static func dequeue(from tableView: UITableView, with dependency:Dependency) -> Self {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.reusableIdentifier) as! Self
            view.inject(dependency)
            return view
        }
    }
    
    public extension Reusable where Self: UITableViewHeaderFooterView, Self.Dependency == Void {
        static func dequeue(from tableView: UITableView) -> Self {
            return dequeue(from: tableView, with: ())
        }
    }
    
    public extension UITableView {
        func register<C: UITableViewCell>(type: C.Type) where C: Reusable {
            register(C.self, forCellReuseIdentifier: C.reusableIdentifier)
        }
        
        func registerNib<C: UITableViewCell>(type: C.Type) where C: Reusable, C: NibType {
            register(C.nib, forCellReuseIdentifier: C.reusableIdentifier)
        }
    }
    
    public extension UITableView {
        func register<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable {
            register(C.self, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
        }
        
        func registerNib<C: UITableViewHeaderFooterView>(type: C.Type) where C: Reusable, C: NibType {
            register(C.nib, forHeaderFooterViewReuseIdentifier: C.reusableIdentifier)
        }
    }
    
#endif

