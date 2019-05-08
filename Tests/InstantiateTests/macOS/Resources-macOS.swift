//
//  Resources-macOS.swift
//  Instantiate
//
//  Created by tarunon on 2017/01/29.
//  Copyright © 2017 tarunon. All rights reserved.
//

#if os(macOS)

import Instantiate
import InstantiateStandard
import AppKit
    
extension NSViewController: ViewLoadBeforeInject {
    
}

class View: NSView, NibInstantiatable {
    typealias Dependency = Int
    var parameter: Int!
    
    func inject(_ dependency: Int) {
        self.parameter = dependency
    }
}

class SubclassView: View {
    var subclassParameter: Int!
    
    override func inject(_ dependency: Int) {
        super.inject(dependency)
        self.subclassParameter = dependency
    }
}

class ViewController: NSViewController, StoryboardInstantiatable {
    typealias Dependency = String
    
    func inject(_ dependency: String) {
        self.label.stringValue = dependency
    }
        
    @IBOutlet weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// Notes: IBDesignable doesn't work if import XCTest in same bundle
// @IBDesignable
class ViewWrapper: NSView, NibInstantiatableWrapper {
    typealias Wrapped = View
    @IBInspectable var parameter: Int = 0 {
        didSet {
            viewIfLoaded?.inject(parameter)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadView(with: parameter)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadView(with: parameter)
    }
}

class ViewController2: NSViewController, StoryboardInstantiatable {
    typealias Parameter = Void
    @IBOutlet weak var viewWrapper: ViewWrapper!
    
    static var storyboard: NSStoryboard = ViewController.storyboard
    static var instantiateSource: InstantiateSource { return .identifier(.from(ViewController2.self)) }
}

class TableViewCell: NSView, Reusable, NibType {
    typealias Dependency = Int
    @IBOutlet weak var label: NSTextField!
    
    func inject(_ dependency: Int) {
        label.stringValue = "\(dependency)"
    }
}

class ViewController3: NSViewController, StoryboardInstantiatable {
    typealias Dependency = (header: String, items: [Int])
    var dataSource: Dependency = (header: "", items: [])
    
    static var storyboard: NSStoryboard = ViewController.storyboard
    static var instantiateSource: InstantiateSource { return .identifier(.from(ViewController3.self)) }
    
    @IBOutlet weak var tableView: NSTableView! {
        didSet {
            tableView.registerNib(type: TableViewCell.self)
        }
    }
    
    func inject(_ dependency: (header: String, items: [Int])) {
        dataSource = dependency
        tableView.reloadData()
    }
}

extension ViewController3: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSource.items.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return TableViewCell.dequeue(from: tableView, with: dataSource.items[row])
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }
}

class CollectionViewCell: NSCollectionViewItem, Reusable, NibType {
    typealias Dependency = String
    @IBOutlet weak var label: NSTextField!
    
    func inject(_ dependency: String) {
        label.stringValue = dependency
    }
}

class CollectionReusableView: NSView, Reusable, NibType {
    typealias Dependency = String
    @IBOutlet weak var label: NSTextField!
    
    func inject(_ dependency: String) {
        label.stringValue = dependency
    }
}

class ViewController4: NSViewController, StoryboardInstantiatable {
    typealias Dependency = [(header: String, items: [String])]
    var dataSource = [(header: String, items: [String])]()
    
    static var storyboard: NSStoryboard = ViewController.storyboard
    static var instantiateSource: InstantiateSource { return .identifier(.from(ViewController4.self)) }
    
    @IBOutlet weak var collectionView: NSCollectionView! {
        didSet {
            collectionView.registerNib(type: CollectionViewCell.self)
            collectionView.registerNib(type: CollectionReusableView.self, forSupplementaryViewOf: NSCollectionView.elementKindSectionHeader)
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    func inject(_ dependency: [(header: String, items: [String])]) {
        dataSource = dependency
        collectionView.reloadData()
    }
}

extension ViewController4: NSCollectionViewDelegateFlowLayout, NSCollectionViewDataSource {
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].items.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 100.0)
    }

    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50.0)
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        return CollectionViewCell.dequeue(from: collectionView, for: indexPath, with: dataSource[indexPath.section].items[indexPath.item])
    }
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
            return CollectionReusableView.dequeue(from: collectionView, of: kind, for: indexPath, with: dataSource[indexPath.section].header)
    }
}

class NibViewController: NSViewController, NibInstantiatable {
    
    @IBOutlet weak var label: NSTextField!
    
    func inject(_ dependency: String) {
        label.stringValue = dependency
    }
}

#endif
