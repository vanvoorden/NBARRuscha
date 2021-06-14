//
//  NBARNetworkSessionTestCase.swift
//  NBARNetworkingTests
//
//  Created by Rick Van Voorden on 6/11/21.
//

import XCTest

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
  
  func testDataTask() {
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
