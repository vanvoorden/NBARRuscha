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
