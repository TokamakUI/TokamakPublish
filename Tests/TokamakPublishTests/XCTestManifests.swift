import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  [
    testCase(TokamakPublishTests.allTests),
  ]
}
#endif
