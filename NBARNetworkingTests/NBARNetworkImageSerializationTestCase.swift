//
//  NBARNetworkImageSerializationTestCase.swift
//  NBNetworkingTests
//
//  Created by Rick Van Voorden on 6/10/21.
//

import XCTest

private func DataTestDouble() -> Foundation.Data {
  return Foundation.Data(Swift.UInt8.min...Swift.UInt8.max)
}

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
  
  private func testFailure() {
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
  
  private func testSuccess() {
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
