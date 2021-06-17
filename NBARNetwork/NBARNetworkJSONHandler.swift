//
//  NBARNetworkJSONHandler.swift
//  NBARNetwork
//
//  Copyright © 2021 North Bronson Software
//
//  This Item is protected by copyright and/or related rights. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use. In addition, no permission is required from the rights-holder(s) for scholarly, educational, or non-commercial uses. For other uses, you need to obtain permission from the rights-holder(s).
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
