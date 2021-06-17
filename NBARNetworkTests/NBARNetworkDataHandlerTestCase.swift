//
//  NBARNetworkDataHandlerTestCase.swift
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
