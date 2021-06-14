//
//  NBARNetworkSessionTestCase.swift
//  NBNetworkingTests
//
//  Created by Rick Van Voorden on 6/11/21.
//

import XCTest

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

private final class NBARNetworkSessionDataTaskTestDouble : NBARNetworkSessionDataTask {
  func cancel() {
    
  }
  
  func resume() {
    
  }
  
  func suspend() {
    
  }
}

private final class NBARNetworkSessionURLSessionTestDouble : NBARNetworkSessionURLSession {
  static let shared = NBARNetworkSessionURLSessionTestDouble()
  
  var request: Foundation.URLRequest?
  var completionHandler: CompletionHandler?
  let dataTask = NBARNetworkSessionDataTaskTestDouble()
  
  func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping CompletionHandler) -> NBARNetworkSessionDataTaskTestDouble {
    self.request = request
    self.completionHandler = completionHandler
    return self.dataTask
  }
  
}

final class NBARNetworkSessionTestCase : XCTestCase {
  private var response: NBARNetworkResponse?
  
  private func testDataTask() {
    let task = NBARNetworkSession<NBARNetworkSessionURLSessionTestDouble>.dataTask(with: URLRequestTestDouble()) { response in
      self.response = response
    }
    
    XCTAssert(NBARNetworkSessionURLSessionTestDouble.shared.request! == URLRequestTestDouble())
    
    let data = DataTestDouble()
    let response = HTTPURLResponseTestDouble()
    let error = NSErrorTestDouble()
    
    NBARNetworkSessionURLSessionTestDouble.shared.completionHandler!(data, response, error)
    
    XCTAssert(self.response!.data! == data)
    XCTAssert(self.response!.response! == response)
    XCTAssert(self.response!.error! as Foundation.NSError === error as Foundation.NSError)
    
    XCTAssert(task === NBARNetworkSessionURLSessionTestDouble.shared.dataTask)
  }
}
