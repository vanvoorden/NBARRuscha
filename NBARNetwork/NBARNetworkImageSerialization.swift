//
//  NBARNetworkImageSerialization.swift
//  NBNetworking
//
//  Created by Rick Van Voorden on 6/10/21.
//

import CoreGraphics
import Foundation

protocol NBARNetworkImageSerializationImage {
  init?(data: Foundation.Data, scale: CoreGraphics.CGFloat)
}

struct NBARNetworkImageSerializationError : Swift.Error {
  enum Code {
    case imageError
  }
  
  let code: Self.Code
  let underlying: Swift.Error?
  
  init(_ code: Self.Code, underlying: Swift.Error? = nil) {
    self.code = code
    self.underlying = underlying
  }
}

struct NBARNetworkImageSerialization<Image> where Image : NBARNetworkImageSerializationImage {
  static func image(with data: Foundation.Data, scale: CoreGraphics.CGFloat) throws -> Image {
    if let image = Image(data: data, scale: scale) {
      return image
    }
    throw NBARNetworkImageSerializationError(.imageError)
  }
}
