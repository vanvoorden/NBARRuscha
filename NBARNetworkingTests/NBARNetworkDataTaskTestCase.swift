//
//  NBARNetworkDataTaskTestCase.swift
//  NBARNetworkingTests
//
//  Created by Rick Van Voorden on 6/12/21.
//

import XCTest

//  TODO: COLLECT THESE HALPERS!
private func DataTestDouble() -> Foundation.Data {
  return Foundation.Data(Swift.UInt8.min...Swift.UInt8.max)
}

private func HTTPURLResponseTestDouble() -> Foundation.URLResponse {
  return Foundation.HTTPURLResponse(url: URLTestDouble(), statusCode: 0, httpVersion: "HTTP/1.1", headerFields: nil)!
}

private func NSErrorTestDouble() -> Foundation.NSError {
  return Foundation.NSError(domain: "domain", code: 0)
}

private func URLRequestTestDouble() -> Foundation.URLRequest {
  return Foundation.URLRequest(url: URLTestDouble())
}

private func URLTestDouble() -> Foundation.URL {
  return Foundation.URL(string: "http://localhost/")!
}

private final class NBARNetworkDataTaskSessionTestDouble : NBARNetworkDataTaskSession {
  static var request: Foundation.URLRequest?
  static var completionHandler: CompletionHandler?
  static let dataTask = NBARNetworkSessionDataTaskTestDouble()
  
  static func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping CompletionHandler) -> NBARNetworkSessionDataTaskTestDouble {
    self.request = request
    self.completionHandler = completionHandler
    return self.dataTask
  }
}

private final class NBARNetworkSessionDataTaskTestDouble : NBARNetworkSessionDataTask {
  var didCancel = false
  var didResume = false
  var didSuspend = false
  
  func cancel() {
    self.didCancel.toggle()
  }
  
  func resume() {
    self.didResume.toggle()
  }
  
  func suspend() {
    self.didSuspend.toggle()
  }
}

final class NBARNetworkDataTaskTestCase : XCTestCase {
  private var response: NBARNetworkResponse?
  
  override func tearDown() {
    NBARNetworkDataTaskSessionTestDouble.dataTask.didCancel = false
    NBARNetworkDataTaskSessionTestDouble.dataTask.didResume = false
    NBARNetworkDataTaskSessionTestDouble.dataTask.didSuspend = false
  }
  
  private func testCancel() {
    let task = NBARNetworkDataTask<NBARNetworkDataTaskSessionTestDouble>(with: URLRequestTestDouble()) { response in
      self.response = response
    }
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.request! == URLRequestTestDouble())
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(), error: NSErrorTestDouble())
    NBARNetworkDataTaskSessionTestDouble.completionHandler!(response)
    
    XCTAssert(self.response!.data! == response.data)
    XCTAssert(self.response!.response! == response.response)
    XCTAssert(self.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didCancel == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didResume == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didSuspend == false)
    
    task.cancel()
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didCancel == true)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didResume == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didSuspend == false)
  }
  
  private func testResume() {
    let task = NBARNetworkDataTask<NBARNetworkDataTaskSessionTestDouble>(with: URLRequestTestDouble()) { response in
      self.response = response
    }
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.request! == URLRequestTestDouble())
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(), error: NSErrorTestDouble())
    NBARNetworkDataTaskSessionTestDouble.completionHandler!(response)
    
    XCTAssert(self.response!.data! == response.data)
    XCTAssert(self.response!.response! == response.response)
    XCTAssert(self.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didCancel == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didResume == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didSuspend == false)
    
    task.resume()
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didCancel == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didResume == true)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didSuspend == false)
  }
  
  private func testSuspend() {
    let task = NBARNetworkDataTask<NBARNetworkDataTaskSessionTestDouble>(with: URLRequestTestDouble()) { response in
      self.response = response
    }
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.request! == URLRequestTestDouble())
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(), error: NSErrorTestDouble())
    NBARNetworkDataTaskSessionTestDouble.completionHandler!(response)
    
    XCTAssert(self.response!.data! == response.data)
    XCTAssert(self.response!.response! == response.response)
    XCTAssert(self.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didCancel == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didResume == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didSuspend == false)
    
    task.suspend()
    
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didCancel == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didResume == false)
    XCTAssert(NBARNetworkDataTaskSessionTestDouble.dataTask.didSuspend == true)
  }
}
