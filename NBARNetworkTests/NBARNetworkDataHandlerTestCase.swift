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
      self.data = nil
      self.error = nil
      
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil, "Status Code \(index)")
      XCTAssert(self.error!.code == .dataError, "Status Code \(index)")
      XCTAssert(self.error!.underlying == nil, "Status Code \(index)")
    }
  }
  
  func testDataSuccess() {
    for index in 200...299 {
      self.data = nil
      self.error = nil
      
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data! == response.data, "Status Code \(index)")
      XCTAssert(self.error == nil, "Status Code \(index)")
    }
  }
  
  func testResponseError() {
    for index in 100...199 {
      self.data = nil
      self.error = nil
      
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil, "Status Code \(index)")
      XCTAssert(self.error!.code == .responseError, "Status Code \(index)")
    }
    
    for index in 300...599 {
      self.data = nil
      self.error = nil
      
      let response = NBARNetworkResponse(data: nil, response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil, "Status Code \(index)")
      XCTAssert(self.error!.code == .responseError, "Status Code \(index)")
    }
  }
  
  func testResponseErrorWithData() {
    for index in 100...199 {
      self.data = nil
      self.error = nil
      
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil, "Status Code \(index)")
      XCTAssert(self.error!.code == .responseError, "Status Code \(index)")
    }
    
    for index in 300...599 {
      self.data = nil
      self.error = nil
      
      let response = NBARNetworkResponse(data: DataTestDouble(), response: HTTPURLResponseTestDouble(statusCode: index), error: NSErrorTestDouble())
      do {
        self.data = try NBARNetworkDataHandler.data(with: response)
      } catch {
        self.error = (error as! NBARNetworkDataHandlerError)
      }
      
      XCTAssert(self.data == nil, "Status Code \(index)")
      XCTAssert(self.error!.code == .responseError, "Status Code \(index)")
    }
  }
}
