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

protocol NBARNetworkJSONHandlerDataHandler {
  static func data(with response: NBARNetworkResponse) throws -> Foundation.Data
}

extension NBARNetworkDataHandler : NBARNetworkJSONHandlerDataHandler{
  
}

protocol NBARNetworkJSONHandlerJSONSerialization {
  associatedtype JSON
  
  static func jsonObject(with data: Foundation.Data, options opt: Foundation.JSONSerialization.ReadingOptions) throws -> Self.JSON
}

struct NBARNetworkJSONHandlerError : Swift.Error {
  enum Code {
    case responseError
    case dataError
    case jsonError
  }
  
  let code: Self.Code
  let underlying: Swift.Error?
  
  init(_ code: Self.Code, underlying: Swift.Error? = nil) {
    self.code = code
    self.underlying = underlying
  }
}

struct NBARNetworkJSONHandler<DataHandler, JSONSerialization> where DataHandler : NBARNetworkJSONHandlerDataHandler, JSONSerialization : NBARNetworkJSONHandlerJSONSerialization {
  static func json(with response: NBARNetworkResponse, options opt: Foundation.JSONSerialization.ReadingOptions) throws -> JSONSerialization.JSON {
    if let mimeType = response.response?.mimeType?.lowercased(),
       mimeType.contains("json") {
      let data: Foundation.Data
      do {
        data = try DataHandler.data(with: response)
      } catch {
        throw NBARNetworkJSONHandlerError(.dataError, underlying: error)
      }
      do {
        return try JSONSerialization.jsonObject(with: data, options: opt)
      } catch {
        throw NBARNetworkJSONHandlerError(.jsonError, underlying: error)
      }
    } else {
      throw NBARNetworkJSONHandlerError(.responseError)
    }
  }
}
