//
//  NBARNetworkJSONHandlerTestCase.swift
//  NBNetworkingTests
//
//  Created by Rick Van Voorden on 6/9/21.
//

import XCTest

private func DataTestDouble() -> Foundation.Data {
  return Foundation.Data(Swift.UInt8.min...Swift.UInt8.max)
}

private func HTTPURLResponseTestDouble(_ headerFields: Swift.Dictionary<Swift.String, Swift.String>? = nil) -> Foundation.URLResponse {
  return Foundation.HTTPURLResponse(url: URLTestDouble(), statusCode: 200, httpVersion: "HTTP/1.1", headerFields: headerFields)!
}

private func NSErrorTestDouble() -> Foundation.NSError {
  return Foundation.NSError(domain: "domain", code: 0, userInfo: nil)
}

private func URLRequestTestDouble() -> Foundation.URLRequest {
  return Foundation.URLRequest(url: URLTestDouble())
}

private func URLTestDouble() -> Foundation.URL {
  return Foundation.URL(string: "http://localhost/")!
}

private struct NBARNetworkJSONHandlerDataHandlerTestDouble : NBARNetworkJSONHandlerDataHandler {
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

private struct NBARNetworkJSONHandlerJSONSerializationTestDouble : NBARNetworkJSONHandlerJSONSerialization {
  static var data: Foundation.Data?
  static var opt: Foundation.JSONSerialization.ReadingOptions?
  static var json: Foundation.NSObject?
  static var error: Foundation.NSError?
  
  static func jsonObject(with data: Foundation.Data, options opt: Foundation.JSONSerialization.ReadingOptions) throws -> Foundation.NSObject {
    self.data = data
    self.opt = opt
    if let json = self.json {
      return json
    }
    throw self.error!
  }
}

final class NBARNetworkJSONHandlerTestCase : XCTestCase {
  private var json: NBARNetworkJSONHandlerJSONSerializationTestDouble.JSON?
  private var error: NBARNetworkJSONHandlerError?
  
  override func tearDown() {
    NBARNetworkJSONHandlerDataHandlerTestDouble.data = nil
    NBARNetworkJSONHandlerDataHandlerTestDouble.response = nil
    NBARNetworkJSONHandlerDataHandlerTestDouble.error = nil
    
    NBARNetworkJSONHandlerJSONSerializationTestDouble.json = nil
    NBARNetworkJSONHandlerJSONSerializationTestDouble.data = nil
    NBARNetworkJSONHandlerJSONSerializationTestDouble.opt = nil
    NBARNetworkJSONHandlerJSONSerializationTestDouble.error = nil
  }
  
  private func testDataError() {
    NBARNetworkJSONHandlerDataHandlerTestDouble.error = NSErrorTestDouble()
    
    NBARNetworkJSONHandlerJSONSerializationTestDouble.error = NSErrorTestDouble()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(["CONTENT-TYPE": "JSON"]), error: NSErrorTestDouble())
    do {
      self.json = try NBARNetworkJSONHandler<NBARNetworkJSONHandlerDataHandlerTestDouble, NBARNetworkJSONHandlerJSONSerializationTestDouble>.json(with: response, options: [])
    } catch {
      self.error = (error as! NBARNetworkJSONHandlerError)
    }
    
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.data! == response.data!)
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.response! == response.response!)
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.data == nil)
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.opt == nil)
    
    XCTAssert(self.json == nil)
    XCTAssert(self.error!.code == .dataError)
    XCTAssert(self.error!.underlying! as Foundation.NSError === NBARNetworkJSONHandlerDataHandlerTestDouble.error!)
  }
  
  private func testJSONError() {
    NBARNetworkJSONHandlerDataHandlerTestDouble.data = DataTestDouble()
    
    NBARNetworkJSONHandlerJSONSerializationTestDouble.error = NSErrorTestDouble()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(["CONTENT-TYPE": "JSON"]), error: NSErrorTestDouble())
    do {
      self.json = try NBARNetworkJSONHandler<NBARNetworkJSONHandlerDataHandlerTestDouble, NBARNetworkJSONHandlerJSONSerializationTestDouble>.json(with: response, options: [])
    } catch {
      self.error = (error as! NBARNetworkJSONHandlerError)
    }
    
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.data! == response.data!)
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.response! == response.response!)
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.data! == NBARNetworkJSONHandlerDataHandlerTestDouble.data!)
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.opt! == [])
    
    XCTAssert(self.json == nil)
    XCTAssert(self.error!.code == .jsonError)
    XCTAssert(self.error!.underlying! as Foundation.NSError === NBARNetworkJSONHandlerJSONSerializationTestDouble.error!)
  }
  
  private func testResponseError() {
    NBARNetworkJSONHandlerDataHandlerTestDouble.error = NSErrorTestDouble()
    
    NBARNetworkJSONHandlerJSONSerializationTestDouble.error = NSErrorTestDouble()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(["CONTENT-TYPE": "IMAGE"]), error: NSErrorTestDouble())
    do {
      self.json = try NBARNetworkJSONHandler<NBARNetworkJSONHandlerDataHandlerTestDouble, NBARNetworkJSONHandlerJSONSerializationTestDouble>.json(with: response, options: [])
    } catch {
      self.error = (error as! NBARNetworkJSONHandlerError)
    }
    
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response == nil)
    
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.data == nil)
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.opt == nil)
    
    XCTAssert(self.json == nil)
    XCTAssert(self.error!.code == .responseError)
    XCTAssert(self.error!.underlying == nil)
  }
  
  private func testJSONSuccess() {
    NBARNetworkJSONHandlerDataHandlerTestDouble.data = DataTestDouble()
    
    NBARNetworkJSONHandlerJSONSerializationTestDouble.json = Foundation.NSObject()
    
    let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(["CONTENT-TYPE": "JSON"]), error: NSErrorTestDouble())
    do {
      self.json = try NBARNetworkJSONHandler<NBARNetworkJSONHandlerDataHandlerTestDouble, NBARNetworkJSONHandlerJSONSerializationTestDouble>.json(with: response, options: [])
    } catch {
      self.error = (error as! NBARNetworkJSONHandlerError)
    }
    
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.data! == response.data!)
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.response! == response.response!)
    XCTAssert(NBARNetworkJSONHandlerDataHandlerTestDouble.response!.error! as Foundation.NSError === response.error! as Foundation.NSError)
    
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.data! == NBARNetworkJSONHandlerDataHandlerTestDouble.data!)
    XCTAssert(NBARNetworkJSONHandlerJSONSerializationTestDouble.opt! == [])
    
    XCTAssert(self.json! === NBARNetworkJSONHandlerJSONSerializationTestDouble.json!)
    XCTAssert(self.error == nil)
  }
}
