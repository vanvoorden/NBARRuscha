//
//  NBARNetworkTests.swift
//  NBARNetworkTests
//
//  Created by Rick Van Voorden on 6/13/21.
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
    XCTAssert(NBARNetwork.ImageOperation.self === NBARNetworkImageOperation<NBARNetworkDataTask<NBARNetworkSession<URLSession>>, NBARNetworkImageHandler<NBARNetworkDataHandler,NBARNetworkImageSerialization<UIImage>>>.self)
  }
  
  func testJSONOperation() {
    XCTAssert(NBARNetwork.JSONOperation.self === NBARNetworkJSONOperation<NBARNetworkDataTask<NBARNetworkSession<URLSession>>, NBARNetworkJSONHandler<NBARNetworkDataHandler, JSONSerialization>>.self)
  }
}
