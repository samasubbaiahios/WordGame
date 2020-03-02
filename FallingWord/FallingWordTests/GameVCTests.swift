//
//  GameVCTests.swift
//  FallingWordTests
//
//  Created by Venkata Subbaiah Sama on 15/09/19.
//  Copyright © 2019 Venkata. All rights reserved.
//

import XCTest
@testable import FallingWord

class GameVCTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGameModelIsNull() {
        let vc = GameVC()
        XCTAssertTrue(vc.wordsList == nil, "View should be nil")
    }
    func testGameDataModel() {
        let vm = GameWord()
        XCTAssertTrue(vm.english == nil, "Model should be nil")
        XCTAssertTrue(vm.english == nil, "Model should be nil")
    }
    func testWords() {
        let manager = WordsManager()
        manager.fetchWords()
        XCTAssertNotNil(manager, "The file should notbe nil.")
    }

}
