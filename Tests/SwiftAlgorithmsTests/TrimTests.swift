//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift Algorithms open source project
//
// Copyright (c) 2020 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

import Algorithms
import XCTest

final class TrimTests: XCTestCase {

  func testEmpty() {
    let resultsEmpty = ([] as [Int]).trimming { $0.isMultiple(of: 2) }
    XCTAssertEqual(resultsEmpty, [])
  }

  func testNoMatch() {
    // No match (nothing trimmed).
    let resultsNoMatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming {
      $0.isMultiple(of: 2)
    }
    XCTAssertEqual(resultsNoMatch, [1, 3, 5, 7, 9, 11, 13, 15])
  }

  func testNoTailMatch() {
    // No tail match (only trim head).
    let resultsNoTailMatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming { $0 < 10 }
    XCTAssertEqual(resultsNoTailMatch, [11, 13, 15])
  }

  func testNoHeadMatch() {
    // No head match (only trim tail).
    let resultsNoHeadMatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming { $0 > 10 }
    XCTAssertEqual(resultsNoHeadMatch, [1, 3, 5, 7, 9])
  }

  func testBothEndsMatch() {
    // Both ends match, some string of >1 elements do not (return that string).
    let results = [2, 10, 11, 15, 20, 21, 100].trimming { $0.isMultiple(of: 2) }
    XCTAssertEqual(results, [11, 15, 20, 21])
  }

  func testEverythingMatches() {
    // Everything matches (trim everything).
    let resultsAllMatch = [1, 3, 5, 7, 9, 11, 13, 15].trimming { _ in true }
    XCTAssertEqual(resultsAllMatch, [])
  }

  func testEverythingButOneMatches() {
    // Both ends match, one element does not (trim all except that element).
    let resultsOne = [2, 10, 12, 15, 20, 100].trimming { $0.isMultiple(of: 2) }
    XCTAssertEqual(resultsOne, [15])
  }

  func testTrimmingPrefix() {
    let results = [2, 10, 12, 15, 20, 100].trimmingPrefix {
      $0.isMultiple(of: 2)
    }
    XCTAssertEqual(results, [15, 20, 100])
  }

  func testTrimmingSuffix() {
    let results = [2, 10, 12, 15, 20, 100].trimmingSuffix {
      $0.isMultiple(of: 2)
    }
    XCTAssertEqual(results, [2, 10, 12, 15])
  }

  // Self == Self.Subsequence
  func testTrimNoAmbiguity() {
    var values = [2, 10, 12, 15, 20, 100] as ArraySlice
    values.trim { $0.isMultiple(of: 2) }
    XCTAssertEqual(values, [15])
  }

  // Self == Self.Subsequence
  func testTrimPrefixNoAmbiguity() {
    var values = [2, 10, 12, 15, 20, 100] as ArraySlice
    values.trimPrefix { $0.isMultiple(of: 2) }
    XCTAssertEqual(values, [15, 20, 100])
  }

  // Self == Self.Subsequence
  func testTrimSuffixNoAmbiguity() {
    var values = [2, 10, 12, 15, 20, 100] as ArraySlice
    values.trimSuffix { $0.isMultiple(of: 2) }
    XCTAssertEqual(values, [2, 10, 12, 15])
  }

  func testTrimRangeReplaceable() {
    var values = [2, 10, 12, 15, 20, 100]
    values.trim { $0.isMultiple(of: 2) }
    XCTAssertEqual(values, [15])
  }

  func testTrimPrefixRangeReplaceable() {
    var values = [2, 10, 12, 15, 20, 100]
    values.trimPrefix { $0.isMultiple(of: 2) }
    XCTAssertEqual(values, [15, 20, 100])
  }

  func testTrimSuffixRangeReplaceable() {
    var values = [2, 10, 12, 15, 20, 100]
    values.trimSuffix { $0.isMultiple(of: 2) }
    XCTAssertEqual(values, [2, 10, 12, 15])
  }
}
