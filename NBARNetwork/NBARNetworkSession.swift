//
//  NBARNetworkSession.swift
//  NBNetworking
//
//  Created by Rick Van Voorden on 6/11/21.
//

import Foundation

protocol NBARNetworkSessionDataTask {
  func cancel()
  func resume()
  func suspend()
}

protocol NBARNetworkSessionURLSession {
  associatedtype DataTask : NBARNetworkSessionDataTask
  associatedtype URLSession : NBARNetworkSessionURLSession
  
  static var shared: Self.URLSession { get }
  
  typealias CompletionHandler = (Foundation.Data?, Foundation.URLResponse?, Swift.Error?) -> Swift.Void
  
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
