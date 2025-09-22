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
