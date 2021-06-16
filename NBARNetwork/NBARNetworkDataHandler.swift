//
//  NBARNetworkDataHandler.swift
//  NBARNetwork
//
//  Created by Rick Van Voorden on 6/8/21.
//

import Foundation

struct NBARNetworkDataHandlerError : Swift.Error {
  enum Code {
    case responseError
    case dataError
  }
  
  let code: Self.Code
  let underlying: Swift.Error?
  
  init(_ code: Self.Code, underlying: Swift.Error? = nil) {
    self.code = code
    self.underlying = underlying
  }
}

struct NBARNetworkDataHandler {
  static func data(with response: NBARNetworkResponse) throws -> Foundation.Data {
    if let statusCode = (response.response as? Foundation.HTTPURLResponse)?.statusCode,
       200...299 ~= statusCode {
      if let data = response.data {
        return data
      } else {
        throw NBARNetworkDataHandlerError(.dataError)
      }
    } else {
      throw NBARNetworkDataHandlerError(.responseError)
    }
  }
}
