//
//  NBARNetworkSessionTestCase.swift
//  NBARNetworkTests
//
//  Copyright © 2021 North Bronson Software
//
//  This Item is protected by copyright and/or related rights. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use. In addition, no permission is required from the rights-holder(s) for scholarly, educational, or non-commercial uses. For other uses, you need to obtain permission from the rights-holder(s).
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
