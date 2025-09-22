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
