//
//  NBARNetworkJSONOperationTestCase.swift
//  NBARNetworkTests
//
//  Created by Rick Van Voorden on 6/12/21.
//

import XCTest

private final class NBARNetworkJSONOperationDataTaskTestDouble : NBARNetworkJSONOperationDataTask {
  static var request: URLRequest?
  static var completionHandler: CompletionHandler?
  
  static var didCancel = false
  static var didResume = false
  static var didSuspend = false
  
  init(with request: Foundation.URLRequest, completionHandler: @escaping CompletionHandler) {
    Self.request = request
    Self.completionHandler = completionHandler
  }
  
  func cancel() {
    Self.didCancel.toggle()
  }
  
  func resume() {
    Self.didResume.toggle()
  }
  
  func suspend() {
    Self.didSuspend.toggle()
  }
}

private struct NBARNetworkJSONOperationJSONHandlerTestDouble : NBARNetworkJSONOperationJSONHandler {
  static var response: NBARNetworkResponse?
  static var opt: Foundation.JSONSerialization.ReadingOptions?
  static var json: Foundation.NSObject?
  static var error: Foundation.NSError?
  
  static func json(with response: NBARNetworkResponse, options opt: Foundation.JSONSerialization.ReadingOptions) throws -> Foundation.NSObject {
    self.response = response
    self.opt = opt
    if let json = self.json {
      return json
    }
    throw self.error!
  }
}

final class NBARNetworkJSONOperationTestCase : XCTestCase {
  private var json: NBARNetworkJSONOperationJSONHandlerTestDouble.JSON?
  private var response: NBARNetworkResponse?
  private var error: Error?
  
  override func tearDown() {
    NBARNetworkJSONOperationDataTaskTestDouble.request = nil
    NBARNetworkJSONOperationDataTaskTestDouble.completionHandler = nil
    
    NBARNetworkJSONOperationDataTaskTestDouble.didCancel = false
    NBARNetworkJSONOperationDataTaskTestDouble.didResume = false
    NBARNetworkJSONOperationDataTaskTestDouble.didSuspend = false
    
    NBARNetworkJSONOperationJSONHandlerTestDouble.response = nil
    NBARNetworkJSONOperationJSONHandlerTestDouble.opt = nil
    NBARNetworkJSONOperationJSONHandlerTestDouble.json = nil
    NBARNetworkJSONOperationJSONHandlerTestDouble.error = nil
  }
  
  func testCancel() {
    let operation = NBARNetworkJSONOperation<NBARNetworkJSONOperationDataTaskTestDouble, NBARNetworkJSONOperationJSONHandlerTestDouble>(with: URLRequestTestDouble(), options: []) { json, response, error in
      self.json = json
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didSuspend == false)
    
    operation.cancel()
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didCancel == true)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didSuspend == false)
  }
  
  func testFailure() {
    NBARNetworkJSONOperationJSONHandlerTestDouble.error = NSErrorTestDouble()
    
    _ = NBARNetworkJSONOperation<NBARNetworkJSONOperationDataTaskTestDouble, NBARNetworkJSONOperationJSONHandlerTestDouble>(with: URLRequestTestDouble(), options: []) { json, response, error in
      self.json = json
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.request! == URLRequestTestDouble())
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(), error: NSErrorTestDouble())
    NBARNetworkJSONOperationDataTaskTestDouble.completionHandler!(response)
    
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.response!.data! == response.data)
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.response!.response! == response.response)
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.opt! == [])
    
    XCTAssert(self.json == nil)
    XCTAssert(self.response!.data! == response.data)
    XCTAssert(self.response!.response! == response.response)
    XCTAssert(self.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(self.error! as NSError === NBARNetworkJSONOperationJSONHandlerTestDouble.error)
  }
  
  func testResume() {
    let operation = NBARNetworkJSONOperation<NBARNetworkJSONOperationDataTaskTestDouble, NBARNetworkJSONOperationJSONHandlerTestDouble>(with: URLRequestTestDouble(), options: []) { json, response, error in
      self.json = json
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didSuspend == false)
    
    operation.resume()
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didResume == true)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didSuspend == false)
  }
  
  func testSuccess() {
    NBARNetworkJSONOperationJSONHandlerTestDouble.json = Foundation.NSObject()
    
    _ = NBARNetworkJSONOperation<NBARNetworkJSONOperationDataTaskTestDouble, NBARNetworkJSONOperationJSONHandlerTestDouble>(with: URLRequestTestDouble(), options: []) { json, response, error in
      self.json = json
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.request! == URLRequestTestDouble())
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(), error: NSErrorTestDouble())
    NBARNetworkJSONOperationDataTaskTestDouble.completionHandler!(response)
    
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.response!.data! == response.data)
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.response!.response! == response.response)
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(NBARNetworkJSONOperationJSONHandlerTestDouble.opt! == [])
    
    XCTAssert(self.json! === NBARNetworkJSONOperationJSONHandlerTestDouble.json)
    XCTAssert(self.response!.data! == response.data)
    XCTAssert(self.response!.response! == response.response)
    XCTAssert(self.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(self.error == nil)
  }
  
  func testSuspend() {
    let operation = NBARNetworkJSONOperation<NBARNetworkJSONOperationDataTaskTestDouble, NBARNetworkJSONOperationJSONHandlerTestDouble>(with: URLRequestTestDouble(), options: []) { json, response, error in
      self.json = json
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didSuspend == false)
    
    operation.suspend()
    
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkJSONOperationDataTaskTestDouble.didSuspend == true)
  }
}
