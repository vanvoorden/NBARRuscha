//
//  NBARNetworkDataHandlerTestCase.swift
//  NBNetworkingTests
//
//  Created by Rick Van Voorden on 6/8/21.
//

import XCTest

private func DataTestDouble() -> Foundation.Data {
  return Foundation.Data(Swift.UInt8.min...Swift.UInt8.max)
}

private func HTTPURLResponseTestDouble(_ statusCode: Swift.Int = 0) -> Foundation.URLResponse {
  return Foundation.HTTPURLResponse(url: URLTestDouble(), statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: nil)!
}

private func NSErrorTestDouble() -> Foundation.NSError {
  return Foundation.NSError(domain: "domain", code: 0)
}

private func URLRequestTestDouble() -> Foundation.URLRequest {
  return Foundation.URLRequest(url: URLTestDouble())
}

private func URLTestDouble() -> Foundation.URL {
  return Foundation.URL(string: "http://localhost/")!
}

final class NBARNetworkDataHandlerTestCase : XCTestCase {
  private var data: Foundation.Data?
  private var error: NBARNetworkDataHandlerError?
  
  private func testDataError() {
    for index in 200...299 {
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .dataError)
      XCTAssert(self.error!.underlying == nil)
    }
  }
  
  private func testDataSuccess() {
    for index in 200...299 {
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data! == response.data)
      XCTAssert(self.error == nil)
    }
  }
  
  private func testResponseError() {
    for index in 100...199 {
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .responseError)
    }
    
    for index in 300...599 {
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .responseError)
    }
  }
  
  private func testResponseErrorWithData() {
    for index in 100...199 {
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .responseError)
    }
    
    for index in 300...599 {
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .responseError)
    }
  }
}
