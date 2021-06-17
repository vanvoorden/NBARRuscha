//
//  NBARNetworkImageHandler.swift
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

import CoreGraphics
import Foundation

protocol NBARNetworkImageHandlerDataHandler {
  static func data(with response: NBARNetworkResponse) throws -> Foundation.Data
}

extension NBARNetworkDataHandler : NBARNetworkImageHandlerDataHandler {

}

protocol NBARNetworkImageHandlerImageSerialization {
  associatedtype Image
  
  static func image(with data: Foundation.Data, scale: CoreGraphics.CGFloat) throws -> Self.Image
}

extension NBARNetworkImageSerialization : NBARNetworkImageHandlerImageSerialization {
  
}

struct NBARNetworkImageHandlerError : Swift.Error {
  enum Code {
    case responseError
    case dataError
    case imageError
  }
  
  let code: Self.Code
  let underlying: Swift.Error?
  
  init(_ code: Self.Code, underlying: Swift.Error? = nil) {
    self.code = code
    self.underlying = underlying
  }
}

struct NBARNetworkImageHandler<DataHandler, ImageSerialization> where DataHandler : NBARNetworkImageHandlerDataHandler, ImageSerialization : NBARNetworkImageHandlerImageSerialization {
  static func image(with response: NBARNetworkResponse, scale: CoreGraphics.CGFloat) throws -> ImageSerialization.Image {
    if let mimeType = response.response?.mimeType?.lowercased(),
       mimeType.contains("image") {
      let data: Foundation.Data
      do {
        data = try DataHandler.data(with: response)
      } catch {
        throw NBARNetworkImageHandlerError(.dataError, underlying: error)
      }
      do {
        return try ImageSerialization.image(with: data, scale: scale)
      } catch {
        throw NBARNetworkImageHandlerError(.imageError, underlying: error)
      }
    } else {
      throw NBARNetworkImageHandlerError(.responseError)
    }
  }
}
