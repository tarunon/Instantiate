//
//  InstantiateTests.swift
//  InstantiateTests
//
//  Created by tarunon on 2017/01/29.
//  Copyright © 2017年 tarunon. All rights reserved.
//

#if os(macOS)

import XCTest
import Instantiate
import Cocoa

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
        XCTAssertEqual(vc.label.stringValue, label)
    }
    
    func testNibinstantiatableWrapper() {
        let vc2 = ViewController2(with: ())
        XCTAssertEqual(vc2.viewWrapper.view.parameter, 271)
    }
    
    func testReusableForTableView() {
        let vc3 = ViewController3(with: (header: "VC3", items: [1, 2, 3, 4]))
        let tableCells: [TableViewCell] =
            [
                vc3.tableView.view(atColumn: 0, row: 0, makeIfNecessary: true),
                vc3.tableView.view(atColumn: 0, row: 1, makeIfNecessary: true),
                vc3.tableView.view(atColumn: 0, row: 2, makeIfNecessary: true),
                vc3.tableView.view(atColumn: 0, row: 3, makeIfNecessary: true)
            ]
            .flatMap { $0 as? TableViewCell }
        XCTAssertEqual(tableCells[0].label.stringValue, "1")
        XCTAssertEqual(tableCells[1].label.stringValue, "2")
        XCTAssertEqual(tableCells[2].label.stringValue, "3")
        XCTAssertEqual(tableCells[3].label.stringValue, "4")
    }
    
    func testReusableForCollectionView() {
        let vc4 = ViewController4(with: [(header: "A", items: ["a", "b", "c", "d"]), (header: "B", items: ["x", "y", "z"])])
        vc4.collectionView.layout()
        
        let headers: [CollectionReusableView] =
            [
                vc4.collectionView.supplementaryView(forElementKind: NSCollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 0)),
                vc4.collectionView.supplementaryView(forElementKind: NSCollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 1))
                ]
                .flatMap { $0 as? CollectionReusableView }
        let collectionCells =
            [
                [
                    vc4.collectionView.item(at: IndexPath(item: 0, section: 0)),
                    vc4.collectionView.item(at: IndexPath(item: 1, section: 0)),
                    vc4.collectionView.item(at: IndexPath(item: 2, section: 0)),
                    vc4.collectionView.item(at: IndexPath(item: 3, section: 0))
                ]
                .flatMap { $0 as? CollectionViewCell },
                [
                    vc4.collectionView.item(at: IndexPath(item: 0, section: 1)),
                    vc4.collectionView.item(at: IndexPath(item: 1, section: 1)),
                    vc4.collectionView.item(at: IndexPath(item: 2, section: 1))
                ]
                .flatMap { $0 as? CollectionViewCell },
            ]
        XCTAssertEqual(headers[0].label.stringValue, "A")
        XCTAssertEqual(headers[1].label.stringValue, "B")
        XCTAssertEqual(collectionCells[0][0].label.stringValue, "a")
        XCTAssertEqual(collectionCells[0][1].label.stringValue, "b")
        XCTAssertEqual(collectionCells[0][2].label.stringValue, "c")
        XCTAssertEqual(collectionCells[0][3].label.stringValue, "d")
        XCTAssertEqual(collectionCells[1][0].label.stringValue, "x")
        XCTAssertEqual(collectionCells[1][1].label.stringValue, "y")
        XCTAssertEqual(collectionCells[1][2].label.stringValue, "z")
    }
    
    func testSubclass() {
        let color = 141
        let view = SubclassView(with: color)
        XCTAssertTrue(view.classForCoder is SubclassView.Type)
        XCTAssertEqual(view.parameter, 141)
        XCTAssertEqual(view.subclassParameter, 141)
    }
    
    static var allTests = [
        ("testNibInstantiatable", testNibInstantiatable),
        ("testStoryboardInstantiatable", testStoryboardInstantiatable),
        ("testNibinstantiatableWrapper", testNibinstantiatableWrapper),
        ("testReusableForTableView", testReusableForTableView),
        ("testReusableForCollectionView", testReusableForCollectionView),
        ("testSubclass", testSubclass)
    ]
}

#endif
