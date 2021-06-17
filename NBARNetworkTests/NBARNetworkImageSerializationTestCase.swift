//
//  NBARNetworkImageSerializationTestCase.swift
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

private struct NBARNetworkImageSerializationImageFailureTestDouble : NBARNetworkImageSerializationImage {
  static var data: Foundation.Data?
  static var scale: CoreGraphics.CGFloat?
  
  init?(data: Foundation.Data, scale: CoreGraphics.CGFloat) {
    Self.data = data
    Self.scale = scale
    return nil
  }
}

private struct NBARNetworkImageSerializationImageSuccessTestDouble : NBARNetworkImageSerializationImage {
  static var data: Foundation.Data?
  static var scale: CoreGraphics.CGFloat?
  
  init?(data: Foundation.Data, scale: CoreGraphics.CGFloat) {
    Self.data = data
    Self.scale = scale
  }
}

final class NBARNetworkImageSerializationTestCase: XCTestCase {
  private var image: NBARNetworkImageSerializationImage?
  private var error: NBARNetworkImageSerializationError?
  
  override func tearDown() {
    NBARNetworkImageSerializationImageFailureTestDouble.data = nil
    NBARNetworkImageSerializationImageFailureTestDouble.scale = nil
    NBARNetworkImageSerializationImageSuccessTestDouble.data = nil
    NBARNetworkImageSerializationImageSuccessTestDouble.scale = nil
  }
  
  func testFailure() {
    let data = DataTestDouble()
    do {
      self.image = try NBARNetworkImageSerialization<NBARNetworkImageSerializationImageFailureTestDouble>.image(with: data, scale: 1.0)
    } catch {
      self.error = (error as! NBARNetworkImageSerializationError)
    }
    
    XCTAssert(NBARNetworkImageSerializationImageFailureTestDouble.data! == data)
    XCTAssert(NBARNetworkImageSerializationImageFailureTestDouble.scale! == 1.0)
    
    XCTAssert(self.image == nil)
    XCTAssert(self.error!.code == .imageError)
  }
  
  func testSuccess() {
    let data = DataTestDouble()
    do {
      self.image = try NBARNetworkImageSerialization<NBARNetworkImageSerializationImageSuccessTestDouble>.image(with: data, scale: 1.0)
    } catch {
      self.error = (error as! NBARNetworkImageSerializationError)
    }
    
    XCTAssert(NBARNetworkImageSerializationImageSuccessTestDouble.data! == data)
    XCTAssert(NBARNetworkImageSerializationImageSuccessTestDouble.scale! == 1.0)
    
    XCTAssert(self.image != nil)
    XCTAssert(self.error == nil)
  }
}
