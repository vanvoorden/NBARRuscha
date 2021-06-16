//
//  NBARRuschaDataModel.swift
//  NBARRuscha
//
//  Copyright © 2021 North Bronson Software
//
//  This Item is protected by copyright and/or related rights. You are free to use this Item in any way that is permitted by the copyright and related rights legislation that applies to your use. In addition, no permission is required from the rights-holder(s) for scholarly, educational, or non-commercial uses. For other uses, you need to obtain permission from the rights-holder(s).
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import NBARKit
import UIKit

extension NBARRuschaPickerResult : NBARPhotosAnchor {
  
}

final class NBARRuschaDataModel : ObservableObject {
  private var requestsDictionary = Dictionary<UUID, NBARRuschaDataModelImageRequest>()
  @Published private var resultsDictionary = Dictionary<UUID, NBARRuschaPickerResult>()
  
  private let queue = DispatchQueue(label: "")
  
  func parseResults(_ results: Array<NBARRuschaPickerResult>) {
    self.queue.async {
      if results.count != 0 {
        var resultsDictionary = Dictionary<UUID, NBARRuschaPickerResult>()
        for result in results {
          resultsDictionary[result.id] = result
        }
        DispatchQueue.main.async {
          self.resultsDictionary = resultsDictionary
        }
      }
    }
  }
}

extension NBARRuschaDataModel : NBARPhotosViewDataModel {
  var anchors: Array<NBARPhotosAnchor> {
    return Array(self.resultsDictionary.values)
  }
  
  func cancelImageRequest(for id: UUID) {
    if let request = self.requestsDictionary[id] {
      self.requestsDictionary[id] = nil
      request.cancel()
    }
  }
  
  func placeholder(for anchor: NBARPhotosAnchor) -> UIImage? {
    if let image = self.resultsDictionary[anchor.id]?.image,
       let request = URLRequest(string: image, cachePolicy: .returnCacheDataElseLoad),
       URLCache.shared.cachedResponse(for: request) != nil {
      return nil
    }
    return UIImage(named: "Getty.png")
  }
  
  func requestImage(for anchor: NBARPhotosAnchor, resultHandler: @escaping (UIImage?, Dictionary<AnyHashable, Any>?) -> Void) -> UUID? {
    if self.requestsDictionary[anchor.id] == nil,
       let image = self.resultsDictionary[anchor.id]?.image {
      let request = NBARRuschaDataModelImageRequest(image)
      request.request { [weak self] result, error in
        DispatchQueue.main.async {
          self?.requestsDictionary[anchor.id] = nil
          resultHandler(result, nil)
        }
      }
      self.requestsDictionary[anchor.id] = request
      return anchor.id
    }
    return nil
  }
}

private final class NBARRuschaDataModelImageRequest {
  private let image: String
  
  private let queue: DispatchQueue
  
  typealias ImageOperation = NBARNetworkImageOperation<NBARNetworkDataTask<NBARNetworkSession<URLSession>>, NBARNetworkImageHandler<NBARNetworkDataHandler,NBARNetworkImageSerialization<UIImage>>>
  
  private var imageOperation: ImageOperation?
  
  typealias JSONOperation = NBARNetworkJSONOperation<NBARNetworkDataTask<NBARNetworkSession<URLSession>>, NBARNetworkJSONHandler<NBARNetworkDataHandler, JSONSerialization>>
  
  private var jsonOperation: JSONOperation?
  
  init(_ image: String) {
    self.image = image
    self.queue = DispatchQueue(label: image)
  }
  
  func cancel() {
    self.queue.async {
      self.imageOperation?.cancel()
      self.jsonOperation?.cancel()
    }
  }
  
  func request(resultHandler: @escaping (UIImage?, Error?) -> Void) {
    self.queue.async {
      if let request = URLRequest(string: self.image, cachePolicy: .reloadIgnoringLocalCacheData) {
        let jsonOperation = JSONOperation(with: request, options: []) { [weak self] result, response, error in
          if let result = result {
            if let self = self,
               let sequences = (((result as? NSDictionary)?.object(forKey: "sequences")) as? NSArray),
               sequences.count != 0,
               let canvases = (((sequences.object(at: 0) as? NSDictionary)?.object(forKey: "canvases")) as? NSArray),
               canvases.count != 0,
               let images = (((canvases.object(at: 0) as? NSDictionary)?.object(forKey: "images")) as? NSArray),
               images.count != 0,
               let resource = (((((images.object(at: 0) as? NSDictionary)?.object(forKey: "resource")) as? NSDictionary)?.object(forKey: "@id")) as? String) {
              let resource = resource.replacingOccurrences(of: "/full/full/0", with: "/full/1080,/0")
              self.queue.async {
                if let request = URLRequest(string: resource, cachePolicy: .returnCacheDataElseLoad) {
                  let imageOperation = ImageOperation(with: request, scale: 1.0) { result, response, error in
                    if let result = result {
                      resultHandler(result, nil)
                    } else {
                      print(response)
                      if let error = error {
                        print(error)
                      }
                      resultHandler(nil, error)
                    }
                  }
                  
                  imageOperation.resume()
                  self.imageOperation = imageOperation
                } else {
                  resultHandler(nil, nil)
                }
              }
            } else {
              print(response)
              resultHandler(nil, nil)
            }
          } else {
            print(response)
            if let error = error {
              print(error)
            }
            resultHandler(nil, error)
          }
        }
        
        jsonOperation.resume()
        self.jsonOperation = jsonOperation
      } else  {
        resultHandler(nil, nil)
      }
    }
  }
}
