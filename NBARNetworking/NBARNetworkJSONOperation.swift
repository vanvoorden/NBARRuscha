//
//  NBARNetworkJSONOperation.swift
//  NBARNetworking
//
//  Created by Rick Van Voorden on 6/12/21.
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
