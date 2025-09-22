//
//  Copyright © 2021 North Bronson Software
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import XCTest

final private class NBARNetworkDataTaskSessionTestDouble : NBARNetworkDataTaskSession {
  static var request: Foundation.URLRequest?
  static var completionHandler: CompletionHandler?
  static let dataTask = NBARNetworkSessionURLSessionDataTaskTestDouble()
  
  static func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping CompletionHandler) -> NBARNetworkSessionURLSessionDataTaskTestDouble {
    self.request = request
    self.completionHandler = completionHandler
    return self.dataTask
  }
}

final private class NBARNetworkSessionURLSessionDataTaskTestDouble : NBARNetworkSessionURLSessionDataTask {
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
  
  func testCancel() {
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
  
  func testResume() {
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
  
  func testSuspend() {
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
