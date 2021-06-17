//
//  NBARNetworkImageOperation.swift
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

protocol NBARNetworkImageOperationDataTask {
  typealias CompletionHandler = (NBARNetworkResponse) -> Swift.Void
  
  init(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler)
  
  func cancel()
  func resume()
  func suspend()
}

extension NBARNetworkDataTask : NBARNetworkImageOperationDataTask {
  
}

protocol NBARNetworkImageOperationImageHandler {
  associatedtype Image
  
  static func image(with response: NBARNetworkResponse, scale: CoreGraphics.CGFloat) throws -> Self.Image
}

extension NBARNetworkImageHandler : NBARNetworkImageOperationImageHandler {
  
}

final class NBARNetworkImageOperation<DataTask, ImageHandler> where DataTask : NBARNetworkImageOperationDataTask, ImageHandler : NBARNetworkImageOperationImageHandler {
  private let dataTask: DataTask
  
  typealias CompletionHandler = (ImageHandler.Image?, NBARNetworkResponse, Swift.Error?) -> Swift.Void
  
  init(with request: Foundation.URLRequest, scale: CoreGraphics.CGFloat, completionHandler: @escaping CompletionHandler) {
    self.dataTask = DataTask.init(with: request) { response in
      do {
        let image = try ImageHandler.image(with: response, scale: scale)
        completionHandler(image, response, nil)
      } catch {
        completionHandler(nil, response, error)
      }
    }
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
