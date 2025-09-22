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

protocol NBARNetworkDataTaskSession {
  associatedtype DataTask : NBARNetworkSessionURLSessionDataTask
  
  typealias CompletionHandler = (NBARNetworkResponse) -> Swift.Void
  static func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler) -> Self.DataTask
}

extension NBARNetworkSession : NBARNetworkDataTaskSession {
  
}

final class NBARNetworkDataTask<Session> where Session : NBARNetworkDataTaskSession {
  private let dataTask: Session.DataTask
  
  typealias CompletionHandler = (NBARNetworkResponse) -> Swift.Void
  
  init(with request: Foundation.URLRequest, completionHandler: @escaping CompletionHandler) {
    self.dataTask = Session.dataTask(with: request, completionHandler: completionHandler)
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
