//
//  NBARNetworkImageOperation.swift
//  NBARNetwork
//
//  Created by Rick Van Voorden on 6/13/21.
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
