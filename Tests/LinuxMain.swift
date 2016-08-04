#if os(Linux)

import XCTest
@testable import ConsoleTestSuite

XCTMain([
    testCase(ConsoleTests.allTests),
    testCase(TerminalTests.allTests),
])

#endif