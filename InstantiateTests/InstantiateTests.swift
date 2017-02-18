//
//  InstantiateTests.swift
//  InstantiateTests
//
//  Created by tarunon on 2017/01/29.
//  Copyright © 2017年 tarunon. All rights reserved.
//

import XCTest
@testable import Instantiate
@testable import InstantiateTestsResource

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
        let color = UIColor.red
        let view = View.instantiate(with: color)
        XCTAssertEqual(view.backgroundColor, color)
    }
    
    func testStoryboardInstantiatable() {
        let label = "Hello world"
        let vc = ViewController.instantiate(with: label)
        XCTAssertEqual(vc.label.text, label)
    }
    
    func testNibinstantiatableWrapper() {
        let vc2 = ViewController2.instantiate()
        XCTAssertEqual(vc2.viewWrapper.view.backgroundColor, UIColor.black)
    }
    
    func testReusableForTableView() {
        let vc3 = ViewController3.instantiate(with: (header: "VC3", items: [1, 2, 3, 4]))
        let tableCells: [TableViewCell] =
            [
                vc3.tableView.cellForRow(at: IndexPath(row: 0, section: 0)),
                vc3.tableView.cellForRow(at: IndexPath(row: 1, section: 0)),
                vc3.tableView.cellForRow(at: IndexPath(row: 2, section: 0)),
                vc3.tableView.cellForRow(at: IndexPath(row: 3, section: 0))
            ]
            .flatMap { $0 as? TableViewCell }
        XCTAssertEqual(tableCells[0].label.text, "1")
        XCTAssertEqual(tableCells[1].label.text, "2")
        XCTAssertEqual(tableCells[2].label.text, "3")
        XCTAssertEqual(tableCells[3].label.text, "4")
        let tableHeader: TableViewHeader = vc3.tableView.headerView(forSection: 0) as! TableViewHeader
        XCTAssertEqual(tableHeader.label.text, "VC3")
    }
    
    func testReusableForCollectionView() {
        let vc4 = ViewController4.instantiate(with: [(header: "A", items: ["a", "b", "c", "d"]), (header: "B", items: ["x", "y", "z"])])
        vc4.collectionView.layoutIfNeeded()
        
        let headers: [CollectionReusableView] =
            [
                vc4.collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 0)),
                vc4.collectionView.supplementaryView(forElementKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: 1))
                ]
                .flatMap { $0 as? CollectionReusableView }
        let collectionCells =
            [
                [
                    vc4.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)),
                    vc4.collectionView.cellForItem(at: IndexPath(item: 1, section: 0)),
                    vc4.collectionView.cellForItem(at: IndexPath(item: 2, section: 0)),
                    vc4.collectionView.cellForItem(at: IndexPath(item: 3, section: 0))
                    ]
                    .flatMap { $0 as? CollectionViewCell },
                [
                    vc4.collectionView.cellForItem(at: IndexPath(item: 0, section: 1)),
                    vc4.collectionView.cellForItem(at: IndexPath(item: 1, section: 1)),
                    vc4.collectionView.cellForItem(at: IndexPath(item: 2, section: 1))
                    ]
                    .flatMap { $0 as? CollectionViewCell },
                ]
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
}
