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
