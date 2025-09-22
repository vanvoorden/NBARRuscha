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
import UIKit

extension Foundation.JSONSerialization : NBARNetworkJSONHandlerJSONSerialization {
  
}

extension Foundation.URLRequest {
  init?(string: Swift.String, cachePolicy: Foundation.URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: Foundation.TimeInterval = 60.0) {
    if let url = Foundation.URL(string: string) {
      self.init(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
    } else {
      return nil
    }
  }
}

extension Foundation.URLSession : NBARNetworkSessionURLSession {
  
}

extension Foundation.URLSessionDataTask : NBARNetworkSessionURLSessionDataTask {
  
}

extension UIKit.UIImage : NBARNetworkImageSerializationImage {
  
}

struct NBARNetwork {
  typealias ImageOperation = NBARNetworkImageOperation<NBARNetworkDataTask<NBARNetworkSession<Foundation.URLSession>>, NBARNetworkImageHandler<NBARNetworkDataHandler,NBARNetworkImageSerialization<UIKit.UIImage>>>
  typealias JSONOperation = NBARNetworkJSONOperation<NBARNetworkDataTask<NBARNetworkSession<Foundation.URLSession>>, NBARNetworkJSONHandler<NBARNetworkDataHandler, Foundation.JSONSerialization>>
}
