//
//  NBARNetworkDataTaskTestCase.swift
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
