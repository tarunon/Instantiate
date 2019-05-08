//
//  Reusable+UICollectionView.swift
//  Instantiate
//
//  Created by tarunon on 2017/06/11.
//

#if os(iOS) || os(tvOS)
    
    import UIKit
    
    public extension Reusable where Self: UICollectionViewCell {
        static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath, with dependency:Dependency) -> Self {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
            cell.inject(dependency)
            return cell
        }
    }
    
    public extension Reusable where Self: UICollectionViewCell, Self.Dependency == Void {
        static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
            return dequeue(from: collectionView, for: indexPath, with: ())
        }
    }
    
    public extension Reusable where Self: UICollectionReusableView {
        static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath, with dependency:Dependency) -> Self {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Self.reusableIdentifier, for: indexPath) as! Self
            view.inject(dependency)
            return view
        }
    }
    
    public extension Reusable where Self: UICollectionReusableView, Self.Dependency == Void {
        static func dequeue(from collectionView: UICollectionView, of kind: String, for indexPath: IndexPath) -> Self {
            return dequeue(from: collectionView, of: kind, for: indexPath, with: ())
        }
    }
    
    public extension UICollectionView {
        func register<C: UICollectionViewCell>(type: C.Type) where C: Reusable {
            register(C.self, forCellWithReuseIdentifier: C.reusableIdentifier)
        }
        
        func registerNib<C: UICollectionViewCell>(type: C.Type) where C: Reusable, C: NibType {
            register(C.nib, forCellWithReuseIdentifier: C.reusableIdentifier)
        }
    }
    
    public extension UICollectionView {
        func register<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable {
            register(C.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
        }
        
        func registerNib<C: UICollectionReusableView>(type: C.Type, forSupplementaryViewOf kind: String) where C: Reusable, C: NibType {
            register(C.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.reusableIdentifier)
        }
    }
    
#endif

