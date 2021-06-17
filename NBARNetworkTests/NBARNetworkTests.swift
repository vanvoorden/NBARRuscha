//
//  NBARNetworkTests.swift
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

func DataTestDouble() -> Foundation.Data {
  return Foundation.Data(Swift.UInt8.min...Swift.UInt8.max)
}

func HTTPURLResponseTestDouble(statusCode: Swift.Int = 200, headerFields: Swift.Dictionary<Swift.String, Swift.String>? = nil) -> Foundation.URLResponse {
  return Foundation.HTTPURLResponse(url: URLTestDouble(), statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: headerFields)!
}

func NSErrorTestDouble() -> Foundation.NSError {
  return Foundation.NSError(domain: "domain", code: 0)
}

func URLRequestTestDouble() -> Foundation.URLRequest {
  return Foundation.URLRequest(url: URLTestDouble())
}

func URLTestDouble() -> Foundation.URL {
  return Foundation.URL(string: "http://localhost/")!
}

final class NBARNetworkTests : XCTestCase {
  func testImageOperation() {
    XCTAssert(NBARNetwork.ImageOperation.self === NBARNetworkImageOperation<NBARNetworkDataTask<NBARNetworkSession<Foundation.URLSession>>, NBARNetworkImageHandler<NBARNetworkDataHandler,NBARNetworkImageSerialization<UIKit.UIImage>>>.self)
  }
  
  func testJSONOperation() {
    XCTAssert(NBARNetwork.JSONOperation.self === NBARNetworkJSONOperation<NBARNetworkDataTask<NBARNetworkSession<Foundation.URLSession>>, NBARNetworkJSONHandler<NBARNetworkDataHandler, Foundation.JSONSerialization>>.self)
  }
}
