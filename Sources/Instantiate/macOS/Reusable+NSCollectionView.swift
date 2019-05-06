//
//  Reusable+NSCollectionView.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(macOS)
    
    import AppKit
    
    public extension Reusable where Self: NSCollectionViewItem {
        static func dequeue(from collectionView: NSCollectionView, for indexPath: IndexPath, with dependency: Dependency) -> Self {
            let cell = collectionView.makeItem(withIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
            cell.inject(dependency)
            return cell
        }
    }
    
    public extension Reusable where Self: NSCollectionViewItem, Dependency == Void {
        static func dequeue(from collectionView: NSCollectionView, for indexPath: IndexPath) -> Self {
            return dequeue(from: collectionView, for: indexPath, with: ())
        }
    }
    
    public extension Reusable where Self: NSView {
        static func dequeue(from collectionView: NSCollectionView, of kind: NSCollectionView.SupplementaryElementKind, for indexPath: IndexPath, with dependency: Dependency) -> Self {
            let view = collectionView.makeSupplementaryView(ofKind: kind, withIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
            view.inject(dependency)
            return view
        }
    }
    
    public extension Reusable where Self: NSView, Dependency == Void {
        static func dequeue(from collectionView: NSCollectionView, of kind: NSCollectionView.SupplementaryElementKind, for indexPath: IndexPath) -> Self {
            return dequeue(from: collectionView, of: kind, for: indexPath, with: ())
        }
    }
    
    public extension NSCollectionView {
        func register<C: NSCollectionViewItem>(type: C.Type) where C: Reusable {
            register(C.self, forItemWithIdentifier: C.reusableIdentifier)
        }
        
        func registerNib<C: NSCollectionViewItem>(type: C.Type) where C: Reusable, C: NibType {
            register(C.nib, forItemWithIdentifier: C.reusableIdentifier)
        }
        
        func register<C: NSView>(type: C.Type, forSupplementaryViewOf kind: SupplementaryElementKind) where C: Reusable {
            register(C.self, forSupplementaryViewOfKind: kind, withIdentifier: C.reusableIdentifier)
        }
        
        func registerNib<C: NSView>(type: C.Type, forSupplementaryViewOf kind: SupplementaryElementKind) where C: Reusable, C: NibType {
            register(C.nib, forSupplementaryViewOfKind: kind, withIdentifier: C.reusableIdentifier)
        }
    }
    
#endif

