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

import Foundation

protocol NBARNetworkSessionURLSessionDataTask {
  func cancel()
  func resume()
  func suspend()
}

protocol NBARNetworkSessionURLSession {
  associatedtype DataTask : NBARNetworkSessionURLSessionDataTask
  associatedtype URLSession : NBARNetworkSessionURLSession
  
  static var shared: Self.URLSession { get }
  
  typealias CompletionHandler = @Sendable (Foundation.Data?, Foundation.URLResponse?, Swift.Error?) -> Swift.Void
  
  func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler) -> Self.DataTask
}

struct NBARNetworkSession<URLSession> where URLSession : NBARNetworkSessionURLSession {
  typealias CompletionHandler = (NBARNetworkResponse) -> Swift.Void
  static func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler) -> URLSession.URLSession.DataTask {
    return URLSession.shared.dataTask(with: request) { data, response, error in
      let response = NBARNetworkResponse(data: data, response: response, error: error)
      completionHandler(response)
    }
  }
}
