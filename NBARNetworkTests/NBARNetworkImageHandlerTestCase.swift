//
//  NBARNetworkImageHandlerTestCase.swift
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

private struct NBARNetworkImageHandlerDataHandlerTestDouble : NBARNetworkImageHandlerDataHandler {
  static var response: NBARNetworkResponse?
  static var data: Foundation.Data?
  static var error: Foundation.NSError?
  
  static func data(with response: NBARNetworkResponse) throws -> Foundation.Data {
    self.response = response
    if let data = self.data {
      return data
    }
    throw self.error!
  }
}

private struct NBARNetworkImageHandlerImageSerializationTestDouble : NBARNetworkImageHandlerImageSerialization {
  static var data: Foundation.Data?
  static var scale: CoreGraphics.CGFloat?
  static var image: Foundation.NSObject?
  static var error: Foundation.NSError?
  
  static func image(with data: Foundation.Data, scale: CoreGraphics.CGFloat) throws -> Foundation.NSObject {
    self.data = data
    self.scale = scale
    if let image = self.image {
      return image
    }
    throw self.error!
  }
}

final class NBARNetworkImageHandlerTestCase: XCTestCase {
  private var image: NBARNetworkImageHandlerImageSerializationTestDouble.Image?
  private var error: NBARNetworkImageHandlerError?
  
  override func tearDown() {
    NBARNetworkImageHandlerDataHandlerTestDouble.data = nil
    NBARNetworkImageHandlerDataHandlerTestDouble.response = nil
    NBARNetworkImageHandlerDataHandlerTestDouble.error = nil
    
    NBARNetworkImageHandlerImageSerializationTestDouble.image = nil
    NBARNetworkImageHandlerImageSerializationTestDouble.data = nil
    NBARNetworkImageHandlerImageSerializationTestDouble.scale = nil
    NBARNetworkImageHandlerImageSerializationTestDouble.error = nil
  }
  
  func testDataError() {
    NBARNetworkImageHandlerDataHandlerTestDouble.error = NSErrorTestDouble()
    
    NBARNetworkImageHandlerImageSerializationTestDouble.error = NSErrorTestDouble()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(headerFields: ["CONTENT-TYPE": "IMAGE"]), error: NSErrorTestDouble())
    do {
      self.image = try NBARNetworkImageHandler<NBARNetworkImageHandlerDataHandlerTestDouble, NBARNetworkImageHandlerImageSerializationTestDouble>.image(with: response, scale: 1.0)
    } catch {
      self.error = (error as! NBARNetworkImageHandlerError)
    }
    
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.data! == response.data!)
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.response! == response.response!)
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.data == nil)
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.scale == nil)
    
    XCTAssert(self.image == nil)
    XCTAssert(self.error!.code == .dataError)
    XCTAssert(self.error!.underlying! as Foundation.NSError === NBARNetworkImageHandlerDataHandlerTestDouble.error!)
  }
  
  func testImageError() {
    NBARNetworkImageHandlerDataHandlerTestDouble.data = DataTestDouble()
    
    NBARNetworkImageHandlerImageSerializationTestDouble.error = NSErrorTestDouble()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(headerFields: ["CONTENT-TYPE": "IMAGE"]), error: NSErrorTestDouble())
    do {
      self.image = try NBARNetworkImageHandler<NBARNetworkImageHandlerDataHandlerTestDouble, NBARNetworkImageHandlerImageSerializationTestDouble>.image(with: response, scale: 1.0)
    } catch {
      self.error = (error as! NBARNetworkImageHandlerError)
    }
    
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.data! == response.data!)
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.response! == response.response!)
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.data! == NBARNetworkImageHandlerDataHandlerTestDouble.data!)
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.scale! == 1.0)
    
    XCTAssert(self.image == nil)
    XCTAssert(self.error!.code == .imageError)
    XCTAssert(self.error!.underlying! as Foundation.NSError === NBARNetworkImageHandlerImageSerializationTestDouble.error!)
  }
  
  func testImageSuccess() {
    NBARNetworkImageHandlerDataHandlerTestDouble.data = DataTestDouble()
    
    NBARNetworkImageHandlerImageSerializationTestDouble.image = Foundation.NSObject()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(headerFields: ["CONTENT-TYPE": "IMAGE"]), error: NSErrorTestDouble())
    do {
      self.image = try NBARNetworkImageHandler<NBARNetworkImageHandlerDataHandlerTestDouble, NBARNetworkImageHandlerImageSerializationTestDouble>.image(with: response, scale: 1.0)
    } catch {
      self.error = (error as! NBARNetworkImageHandlerError)
    }
    
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.data! == response.data!)
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.response! == response.response!)
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.data! == NBARNetworkImageHandlerDataHandlerTestDouble.data!)
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.scale! == 1.0)
    
    XCTAssert(self.image! === NBARNetworkImageHandlerImageSerializationTestDouble.image!)
    XCTAssert(self.error == nil)
  }
  
  func testResponseError() {
    NBARNetworkImageHandlerDataHandlerTestDouble.error = NSErrorTestDouble()
    
    NBARNetworkImageHandlerImageSerializationTestDouble.error = NSErrorTestDouble()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(headerFields: ["CONTENT-TYPE": "JSON"]), error: NSErrorTestDouble())
    do {
      self.image = try NBARNetworkImageHandler<NBARNetworkImageHandlerDataHandlerTestDouble, NBARNetworkImageHandlerImageSerializationTestDouble>.image(with: response, scale: 1.0)
    } catch {
      self.error = (error as! NBARNetworkImageHandlerError)
    }
    
    XCTAssert(NBARNetworkImageHandlerDataHandlerTestDouble.response == nil)
    
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.data == nil)
    XCTAssert(NBARNetworkImageHandlerImageSerializationTestDouble.scale == nil)
    
    XCTAssert(self.image == nil)
    XCTAssert(self.error!.code == .responseError)
    XCTAssert(self.error!.underlying == nil)
  }
}
