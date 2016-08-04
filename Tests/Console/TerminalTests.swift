//
//  TerminalTests.swift
//  Console
//
//  Created by Sven A. Schmidt on 04/08/2016.
//
//

import XCTest
import Foundation

@testable import Console


class TerminalTests: XCTestCase {

    static let allTests = [
        ("testSubexecute", testSubexecute),
        ]

    func testSubexecute() {
        let t = Terminal(arguments: [])
        if let res = try? t.subexecute("ls -l /tmp") {
            // lrwxr-xr-x@ 1 root  wheel  11 10 Sep  2015 /tmp -> private/tmp
            // FIXME: remove after Grand Renaming lands on Linux
            #if os(OSX)
                let parts = res.components(separatedBy: CharacterSet.whitespaces)
            #else
                let parts = res.components(separatedBy: NSCharacterSet.whitespaces())
            #endif
            XCTAssertEqual(parts[2], "root")
        } else {
            XCTFail("response must not be nil")
        }
    }

}
