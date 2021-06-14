//
//  NBARNetworkImageHandlerTestCase.swift
//  NBARNetworkingTests
//
//  Created by Rick Van Voorden on 6/10/21.
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
