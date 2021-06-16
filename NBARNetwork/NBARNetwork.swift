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
  init?(string: String, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0) {
    if let url = URL(string: string) {
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
  typealias ImageOperation = NBARNetworkImageOperation<NBARNetworkDataTask<NBARNetworkSession<URLSession>>, NBARNetworkImageHandler<NBARNetworkDataHandler,NBARNetworkImageSerialization<UIImage>>>
  typealias JSONOperation = NBARNetworkJSONOperation<NBARNetworkDataTask<NBARNetworkSession<URLSession>>, NBARNetworkJSONHandler<NBARNetworkDataHandler, JSONSerialization>>
}
