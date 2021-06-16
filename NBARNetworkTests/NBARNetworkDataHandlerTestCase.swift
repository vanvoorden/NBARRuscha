//
//  NBARNetworkDataHandlerTestCase.swift
//  NBARNetworkTests
//
//  Created by Rick Van Voorden on 6/8/21.
//

import XCTest

final class NBARNetworkDataHandlerTestCase : XCTestCase {
  private var data: Foundation.Data?
  private var error: NBARNetworkDataHandlerError?
  
  func testDataError() {
    for index in 200...299 {
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
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
  
  func testDataSuccess() {
    for index in 200...299 {
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data! == response.data)
      XCTAssert(self.error == nil)
    }
  }
  
  func testResponseError() {
    for index in 100...199 {
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .responseError)
    }
    
    for index in 300...599 {
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .responseError)
    }
  }
  
  func testResponseErrorWithData() {
    for index in 100...199 {
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil)
      XCTAssert(self.error!.code == .responseError)
    }
    
    for index in 300...599 {
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
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
