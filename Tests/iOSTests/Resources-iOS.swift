//
//  Resources.swift
//  Instantiate
//
//  Created by tarunon on 2017/01/29.
//  Copyright © 2017 tarunon. All rights reserved.
//

#if os(iOS)
    
import Instantiate
import InstantiateStandard

import UIKit

class View: UIView, NibInstantiatable {
    typealias Dependency = UIColor
    var parameter: Dependency!
    
    func inject(_ dependency: UIColor) {
        self.backgroundColor = dependency
    }
}

class SubclassView: View {
    override func inject(_ dependency: UIColor) {
        super.inject(dependency)
        self.tintColor = dependency
    }
}

class ViewController: UIViewController, StoryboardInstantiatable {
    typealias Dependency = String
    
    func inject(_ dependency: String) {
        self.label.text = dependency
    }
        
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// Notes: IBDesignable doesn't work if import XCTest in same bundle
// @IBDesignable
class ViewWrapper: UIView, NibInstantiatableWrapper {
    typealias Wrapped = View
    @IBInspectable var color: UIColor = .white {
        didSet {
            viewIfLoaded?.inject(color)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadView(with: color)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadView(with: color)
    }
}

class ViewController2: UIViewController, StoryboardInstantiatable {
    typealias Parameter = Void
    @IBOutlet weak var viewWrapper: ViewWrapper!
    
    static var storyboard: UIStoryboard = ViewController.storyboard
    static var instantiateSource: InstantiateSource { return .identifier(identifier(of: ViewController2.self)) }
}

class TableViewCell: UITableViewCell, Reusable, NibType {
    typealias Dependency = Int
    @IBOutlet weak var label: UILabel!
    
    func inject(_ dependency: Int) {
        label.text = "\(dependency)"
    }
}

class TableViewHeader: UITableViewHeaderFooterView, Reusable, NibType {
    typealias Dependency = String
    @IBOutlet weak var label: UILabel!
    
    func inject(_ dependency: String) {
        label.text = dependency
    }
}

class ViewController3: UIViewController, StoryboardInstantiatable {
    typealias Dependency = (header: String, items: [Int])
    var dataSource: Dependency = (header: "", items: [])
    
    static var storyboard: UIStoryboard = ViewController.storyboard
    static var instantiateSource: InstantiateSource { return .identifier(identifier(of: ViewController3.self)) }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNib(type: TableViewCell.self)
            tableView.registerNib(type: TableViewHeader.self) 
        }
    }
    
    func inject(_ dependency: (header: String, items: [Int])) {
        dataSource = dependency
        tableView.reloadData()
    }
}

extension ViewController3: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableViewHeader.dequeue(from: tableView, with: dataSource.header)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return TableViewCell.dequeue(from: tableView, for: indexPath, with: dataSource.items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

class CollectionViewCell: UICollectionViewCell, Reusable, NibType {
    typealias Dependency = String
    @IBOutlet weak var label: UILabel!
    
    func inject(_ dependency: String) {
        label.text = dependency
    }
}

class CollectionReusableView: UICollectionReusableView, Reusable, NibType {
    typealias Dependency = String
    @IBOutlet weak var label: UILabel!
    
    func inject(_ dependency: String) {
        label.text = dependency
    }
}

class ViewController4: UIViewController, StoryboardInstantiatable {
    typealias Dependency = [(header: String, items: [String])]
    var dataSource = [(header: String, items: [String])]()
    
    static var storyboard: UIStoryboard = ViewController.storyboard
    static var instantiateSource: InstantiateSource { return .identifier(identifier(of: ViewController4.self)) }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(type: CollectionViewCell.self)
            collectionView.registerNib(type: CollectionReusableView.self, forSupplementaryViewOf: UICollectionElementKindSectionHeader)
        }
    }
    
    func inject(_ dependency: [(header: String, items: [String])]) {
        dataSource = dependency
        collectionView.reloadData()
    }
}

extension ViewController4: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return CollectionViewCell.dequeue(from: collectionView, for: indexPath, with: dataSource[indexPath.section].items[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return CollectionReusableView.dequeue(from: collectionView, of: kind, for: indexPath, with: dataSource[indexPath.section].header)
    }
}

#endif
