//
//  NBARNetworkImageHandler.swift
//  NBNetworking
//
//  Created by Rick Van Voorden on 6/10/21.
//

import CoreGraphics
import Foundation

protocol NBARNetworkImageHandlerDataHandler {
  static func data(with response: NBARNetworkResponse) throws -> Foundation.Data
}

//extension NBARNetworkDataHandler : NBARNetworkImageHandlerDataHandler {
//
//}

protocol NBARNetworkImageHandlerImageSerialization {
  associatedtype Image
  
  static func image(with data: Foundation.Data, scale: CoreGraphics.CGFloat) throws -> Self.Image
}

//extension NBARNetworkImageSerialization : NBARNetworkImageHandlerImageSerialization {
//  
//}

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
