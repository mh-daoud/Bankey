//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by admin on 21/11/2023.
//

import Foundation

import XCTest

@testable import Bankey

class CurrencyFormatterTests: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDownDollersIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929467.43)
        XCTAssertEqual(result.0, "929,467")
        XCTAssertEqual(result.1, "43")
    }
    
    func testDollersFormatted() throws {
        let result = formatter.dollarsFormatted(929467.43)
        XCTAssertEqual(result, "$929,467.43")
    }
    
    func testZeroDollersFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "$0.00")
    }
}
