//
//  NBARNetworkImageOperationTestCase.swift
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

final private class NBARNetworkImageOperationDataTaskTestDouble : NBARNetworkImageOperationDataTask {
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

private struct NBARNetworkImageOperationImageHandlerTestDouble : NBARNetworkImageOperationImageHandler {
  static var response: NBARNetworkResponse?
  static var scale: CoreGraphics.CGFloat?
  static var image: Foundation.NSObject?
  static var error: Foundation.NSError?
  
  static func image(with response: NBARNetworkResponse, scale: CoreGraphics.CGFloat) throws -> Foundation.NSObject {
    self.response = response
    self.scale = scale
    if let image = self.image {
      return image
    }
    throw self.error!
  }
}

final class NBARNetworkImageOperationTestCase: XCTestCase {
  private var image: NBARNetworkImageOperationImageHandlerTestDouble.Image?
  private var response: NBARNetworkResponse?
  private var error: Error?
  
  override func tearDown() {
    NBARNetworkImageOperationDataTaskTestDouble.request = nil
    NBARNetworkImageOperationDataTaskTestDouble.completionHandler = nil
    
    NBARNetworkImageOperationDataTaskTestDouble.didCancel = false
    NBARNetworkImageOperationDataTaskTestDouble.didResume = false
    NBARNetworkImageOperationDataTaskTestDouble.didSuspend = false
    
    NBARNetworkImageOperationImageHandlerTestDouble.response = nil
    NBARNetworkImageOperationImageHandlerTestDouble.scale = nil
    NBARNetworkImageOperationImageHandlerTestDouble.image = nil
    NBARNetworkImageOperationImageHandlerTestDouble.error = nil
  }
  
  func testCancel() {
    let operation = NBARNetworkImageOperation<NBARNetworkImageOperationDataTaskTestDouble, NBARNetworkImageOperationImageHandlerTestDouble>(with: URLRequestTestDouble(), scale: 1.0) { image, response, error in
      self.image = image
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didSuspend == false)
    
    operation.cancel()
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didCancel == true)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didSuspend == false)
  }
  
  func testFailure() {
    NBARNetworkImageOperationImageHandlerTestDouble.error = NSErrorTestDouble()
    
    _ = NBARNetworkImageOperation<NBARNetworkImageOperationDataTaskTestDouble, NBARNetworkImageOperationImageHandlerTestDouble>(with: URLRequestTestDouble(), scale: 1.0) { image, response, error in
      self.image = image
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.request! == URLRequestTestDouble())
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(), error: NSErrorTestDouble())
    NBARNetworkImageOperationDataTaskTestDouble.completionHandler!(response)
    
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.response!.data! == response.data)
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.response!.response! == response.response)
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.scale! == 1.0)
    
    XCTAssert(self.image == nil)
    XCTAssert(self.response!.data! == response.data)
    XCTAssert(self.response!.response! == response.response)
    XCTAssert(self.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(self.error! as NSError === NBARNetworkImageOperationImageHandlerTestDouble.error)
  }
  
  func testResume() {
    let operation = NBARNetworkImageOperation<NBARNetworkImageOperationDataTaskTestDouble, NBARNetworkImageOperationImageHandlerTestDouble>(with: URLRequestTestDouble(), scale: 1.0) { image, response, error in
      self.image = image
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didSuspend == false)
    
    operation.resume()
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didResume == true)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didSuspend == false)
  }
  
  func testSuccess() {
    NBARNetworkImageOperationImageHandlerTestDouble.image = Foundation.NSObject()
    
    _ = NBARNetworkImageOperation<NBARNetworkImageOperationDataTaskTestDouble, NBARNetworkImageOperationImageHandlerTestDouble>(with: URLRequestTestDouble(), scale: 1.0) { image, response, error in
      self.image = image
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.request! == URLRequestTestDouble())
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(), error: NSErrorTestDouble())
    NBARNetworkImageOperationDataTaskTestDouble.completionHandler!(response)
    
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.response!.data! == response.data)
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.response!.response! == response.response)
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(NBARNetworkImageOperationImageHandlerTestDouble.scale! == 1.0)
    
    XCTAssert(self.image! === NBARNetworkImageOperationImageHandlerTestDouble.image)
    XCTAssert(self.response!.data! == response.data)
    XCTAssert(self.response!.response! == response.response)
    XCTAssert(self.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    XCTAssert(self.error == nil)
  }
  
  func testSuspend() {
    let operation = NBARNetworkImageOperation<NBARNetworkImageOperationDataTaskTestDouble, NBARNetworkImageOperationImageHandlerTestDouble>(with: URLRequestTestDouble(), scale: 1.0) { image, response, error in
      self.image = image
      self.response = response
      self.error = error
    }
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didSuspend == false)
    
    operation.suspend()
    
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didCancel == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didResume == false)
    XCTAssert(NBARNetworkImageOperationDataTaskTestDouble.didSuspend == true)
  }
}
