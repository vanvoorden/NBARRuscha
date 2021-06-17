//
//  NBARNetwork.swift
//  NBARNetwork
//
//  Created by Rick Van Voorden on 6/13/21.
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
