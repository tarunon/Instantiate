//
//  InstantiateTests.swift
//  InstantiateTests
//
//  Created by tarunon on 2017/01/29.
//  Copyright © 2017年 tarunon. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
#endif
#if os(macOS)
    import AppKit
    extension NSTextField {
        var text: String? {
            return stringValue
        }
    }
#endif

import XCTest
import Instantiate

class InstantiateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNibInstantiatable() {
        let parameter = 314
        let view = View(with: parameter)
        XCTAssertEqual(view.parameter, parameter)
    }
    
    func testStoryboardInstantiatable() {
        let label = "Hello world"
        let vc = ViewController(with: label)
        XCTAssertEqual(vc.label.text, label)
    }
    
    func testNibinstantiatableWrapper() {
        let vc2 = ViewController2(with: ())
        XCTAssertEqual(vc2.viewWrapper.view.parameter, 271)
    }
    
    func testReusableForTableView() {
        let vc3 = ViewController3(with: (header: "VC3", items: [1, 2, 3, 4]))
        #if os(iOS) || os(tvOS)
            let tableCells: [TableViewCell] =
                [
                    vc3.tableView.cellForRow(at: IndexPath(row: 0, section: 0)),
                    vc3.tableView.cellForRow(at: IndexPath(row: 1, section: 0)),
                    vc3.tableView.cellForRow(at: IndexPath(row: 2, section: 0)),
                    vc3.tableView.cellForRow(at: IndexPath(row: 3, section: 0))
                ]
                .compactMap { $0 as? TableViewCell }
        #endif
        #if os(macOS)
            let tableCells: [TableViewCell] =
                [
                    vc3.tableView.view(atColumn: 0, row: 0, makeIfNecessary: true),
                    vc3.tableView.view(atColumn: 0, row: 1, makeIfNecessary: true),
                    vc3.tableView.view(atColumn: 0, row: 2, makeIfNecessary: true),
                    vc3.tableView.view(atColumn: 0, row: 3, makeIfNecessary: true)
                ]
                .compactMap { $0 as? TableViewCell }
        #endif
        XCTAssertEqual(tableCells[0].label.text, "1")
        XCTAssertEqual(tableCells[1].label.text, "2")
        XCTAssertEqual(tableCells[2].label.text, "3")
        XCTAssertEqual(tableCells[3].label.text, "4")
        #if os(iOS) || os(tvOS)
            let tableHeader: TableViewHeader = vc3.tableView.headerView(forSection: 0) as! TableViewHeader
            XCTAssertEqual(tableHeader.label.text, "VC3")
        #endif
    }
    
    func testReusableForCollectionView() {
        let vc4 = ViewController4(with: [(header: "A", items: ["a", "b", "c", "d"]), (header: "B", items: ["x", "y", "z"])])
        #if os(iOS) || os(tvOS)
            vc4.collectionView.layoutIfNeeded()
        #endif
        #if os(macOS)
            vc4.collectionView.layout()
        #endif

        #if os(iOS) || os(tvOS)
            let headers: [CollectionReusableView] =
                [
                    vc4.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)),
                    vc4.collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1))
                ]
                .compactMap { $0 as? CollectionReusableView }
        #endif
        #if os(macOS)
            let headers: [CollectionReusableView] =
                [
                    vc4.collectionView.supplementaryView(forElementKind: NSCollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)),
                    vc4.collectionView.supplementaryView(forElementKind: NSCollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 1))
                ]
                .compactMap { $0 as? CollectionReusableView }
        #endif
        #if os(iOS) || os(tvOS)
            let collectionCells =
                [
                    [
                        vc4.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)),
                        vc4.collectionView.cellForItem(at: IndexPath(item: 1, section: 0)),
                        vc4.collectionView.cellForItem(at: IndexPath(item: 2, section: 0)),
                        vc4.collectionView.cellForItem(at: IndexPath(item: 3, section: 0))
                    ]
                    .compactMap { $0 as? CollectionViewCell },
                    [
                        vc4.collectionView.cellForItem(at: IndexPath(item: 0, section: 1)),
                        vc4.collectionView.cellForItem(at: IndexPath(item: 1, section: 1)),
                        vc4.collectionView.cellForItem(at: IndexPath(item: 2, section: 1))
                    ]
                    .compactMap { $0 as? CollectionViewCell },
                ]
        #endif
        #if os(macOS)
            let collectionCells =
                [
                    [
                        vc4.collectionView.item(at: IndexPath(item: 0, section: 0)),
                        vc4.collectionView.item(at: IndexPath(item: 1, section: 0)),
                        vc4.collectionView.item(at: IndexPath(item: 2, section: 0)),
                        vc4.collectionView.item(at: IndexPath(item: 3, section: 0))
                    ]
                    .compactMap { $0 as? CollectionViewCell },
                    [
                        vc4.collectionView.item(at: IndexPath(item: 0, section: 1)),
                        vc4.collectionView.item(at: IndexPath(item: 1, section: 1)),
                        vc4.collectionView.item(at: IndexPath(item: 2, section: 1))
                    ]
                    .compactMap { $0 as? CollectionViewCell },
                ]
        #endif
        XCTAssertEqual(headers[0].label.text, "A")
        XCTAssertEqual(headers[1].label.text, "B")
        XCTAssertEqual(collectionCells[0][0].label.text, "a")
        XCTAssertEqual(collectionCells[0][1].label.text, "b")
        XCTAssertEqual(collectionCells[0][2].label.text, "c")
        XCTAssertEqual(collectionCells[0][3].label.text, "d")
        XCTAssertEqual(collectionCells[1][0].label.text, "x")
        XCTAssertEqual(collectionCells[1][1].label.text, "y")
        XCTAssertEqual(collectionCells[1][2].label.text, "z")
    }
    
    func testSubclass() {
        let parameter = 141
        let view = SubclassView(with: parameter)
        XCTAssertTrue(view.classForCoder is SubclassView.Type)
        XCTAssertEqual(view.parameter, parameter)
        XCTAssertEqual(view.subclassParameter, parameter)
    }
    
    func testNibViewController() {
        let parameter = "NibViewController"
        let viewController = NibViewController(with: parameter)
        XCTAssertEqual(viewController.label.text, parameter)
    }
    
    static var allTests = [
        ("testNibInstantiatable", testNibInstantiatable),
        ("testStoryboardInstantiatable", testStoryboardInstantiatable),
        ("testNibinstantiatableWrapper", testNibinstantiatableWrapper),
        ("testReusableForTableView", testReusableForTableView),
        ("testReusableForCollectionView", testReusableForCollectionView),
        ("testSubclass", testSubclass),
        ("testNibViewController", testNibViewController)
    ]
}
