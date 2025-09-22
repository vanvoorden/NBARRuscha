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

final private class NBARNetworkSessionURLSessionDataTaskTestDouble : NBARNetworkSessionURLSessionDataTask {
  func cancel() {
    
  }
  
  func resume() {
    
  }
  
  func suspend() {
    
  }
}

final private class NBARNetworkSessionURLSessionTestDouble : NBARNetworkSessionURLSession {
  static let shared = NBARNetworkSessionURLSessionTestDouble()
  
  var request: Foundation.URLRequest?
  var completionHandler: CompletionHandler?
  let dataTask = NBARNetworkSessionURLSessionDataTaskTestDouble()
  
  func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping CompletionHandler) -> NBARNetworkSessionURLSessionDataTaskTestDouble {
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
