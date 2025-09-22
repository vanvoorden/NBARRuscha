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
