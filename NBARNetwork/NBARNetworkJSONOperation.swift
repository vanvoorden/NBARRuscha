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

protocol NBARNetworkJSONOperationDataTask {
  typealias CompletionHandler = (NBARNetworkResponse) -> Swift.Void
  
  init(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler)
  
  func cancel()
  func resume()
  func suspend()
}

extension NBARNetworkDataTask : NBARNetworkJSONOperationDataTask {
  
}

protocol NBARNetworkJSONOperationJSONHandler {
  associatedtype JSON
  
  static func json(with response: NBARNetworkResponse, options opt: Foundation.JSONSerialization.ReadingOptions) throws -> Self.JSON
}

extension NBARNetworkJSONHandler : NBARNetworkJSONOperationJSONHandler {
  
}

final class NBARNetworkJSONOperation<DataTask, JSONHandler> where DataTask : NBARNetworkJSONOperationDataTask, JSONHandler : NBARNetworkJSONOperationJSONHandler {
  private let dataTask: DataTask
  
  typealias CompletionHandler = (JSONHandler.JSON?, NBARNetworkResponse, Swift.Error?) -> Swift.Void
  
  init(with request: Foundation.URLRequest, options opt: Foundation.JSONSerialization.ReadingOptions, completionHandler: @escaping CompletionHandler) {
    self.dataTask = DataTask.init(with: request) { response in
      do {
        let json = try JSONHandler.json(with: response, options: opt)
        completionHandler(json, response, nil)
      } catch {
        completionHandler(nil, response, error)
      }
    }
  }
  
  func cancel() {
    self.dataTask.cancel()
  }
  
  func resume() {
    self.dataTask.resume()
  }
  
  func suspend() {
    self.dataTask.suspend()
  }
}
