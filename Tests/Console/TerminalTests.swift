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
        ("testSize", testSize),
        ]

    func testSubexecute() {
        let t = Terminal(arguments: [])
        if let res = try? t.subexecute("ls -ld /tmp") {
            // FIXME: remove after Grand Renaming lands on Linux
            #if os(OSX)
                // lrwxr-xr-x@ 1 root  wheel  11 10 Sep  2015 /tmp -> private/tmp
                let parts = res.components(separatedBy: CharacterSet.whitespaces)
            #else
                // drwxrwxrwt 3 root root 4096 Aug  4 11:11 /tmp
                let parts = res.components(separatedBy: NSCharacterSet.whitespaces())
            #endif
            XCTAssertEqual(parts[2], "root")
        } else {
            XCTFail("response must not be nil")
        }
    }

    func testSize() {
        let t = Terminal(arguments: [])
        XCTAssertEqual(t.size.width, 80)
        XCTAssertEqual(t.size.height, 24)
    }

    func testPopen() {
        if let res = try? popen(["ls", "-l"]) {
            print("res: \(res)")
            XCTAssertEqual(res, "foo")
        } else {
            XCTFail()
        }
    }

}
