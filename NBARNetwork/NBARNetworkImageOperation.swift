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

import CoreGraphics
import Foundation

protocol NBARNetworkImageOperationDataTask {
  typealias CompletionHandler = (NBARNetworkResponse) -> Swift.Void
  
  init(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler)
  
  func cancel()
  func resume()
  func suspend()
}

extension NBARNetworkDataTask : NBARNetworkImageOperationDataTask {
  
}

protocol NBARNetworkImageOperationImageHandler {
  associatedtype Image
  
  static func image(with response: NBARNetworkResponse, scale: CoreGraphics.CGFloat) throws -> Self.Image
}

extension NBARNetworkImageHandler : NBARNetworkImageOperationImageHandler {
  
}

final class NBARNetworkImageOperation<DataTask, ImageHandler> where DataTask : NBARNetworkImageOperationDataTask, ImageHandler : NBARNetworkImageOperationImageHandler {
  private let dataTask: DataTask
  
  typealias CompletionHandler = (ImageHandler.Image?, NBARNetworkResponse, Swift.Error?) -> Swift.Void
  
  init(with request: Foundation.URLRequest, scale: CoreGraphics.CGFloat, completionHandler: @escaping CompletionHandler) {
    self.dataTask = DataTask.init(with: request) { response in
      do {
        let image = try ImageHandler.image(with: response, scale: scale)
        completionHandler(image, response, nil)
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
