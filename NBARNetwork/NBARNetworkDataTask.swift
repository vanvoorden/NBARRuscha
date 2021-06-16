//
//  NBARNetworkDataTask.swift
//  NBARNetwork
//
//  Created by Rick Van Voorden on 6/12/21.
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
