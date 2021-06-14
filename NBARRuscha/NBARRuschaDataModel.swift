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
       let url = URL(string: image) {
      let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
      if URLCache.shared.cachedResponse(for: request) != nil {
        return nil
      }
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
          resultHandler(result, error)
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
  
  private var array = Array<URLSessionDataTask>()
  private var backgroundTask: UIBackgroundTaskIdentifier?
  private var didCancel = false
  private var didRequest = false
  
  private let queue: DispatchQueue
  
  init(_ image: String) {
    self.image = image
    self.queue = DispatchQueue(label: image)
  }
  
  func cancel() {
    self.queue.async {
      if self.didRequest {
        self.didCancel = true
        for task in self.array {
          task.cancel()
        }
      }
    }
  }
  
  func request(resultHandler: @escaping (UIImage?, Dictionary<AnyHashable, Any>?) -> Void) {
    self.queue.async {
      if self.didRequest == false {
        self.didRequest = true
        let task = URLSession.shared.jsonTask(with: self.image) { [weak self] result, response, error in
          if let error = error {
            if let response = response {
              print(response)
            }
            print(error)
            resultHandler(nil, nil)
          } else {
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
                if self.didCancel == false {
                  let task = URLSession.shared.imageTask(with: resource) { result, response, error in
                    if let error = error {
                      if let response = response {
                        print(response)
                      }
                      print(error)
                      resultHandler(nil, nil)
                    } else {
                      resultHandler(result, nil)
                    }
                  }
                  
                  if let task = task {
                    task.resume()
                    self.array.append(task)
                  } else {
                    resultHandler(nil, nil)
                  }
                }
              }
            } else {
              resultHandler(nil, nil)
            }
          }
        }
        
        if let task = task {
          task.resume()
          self.array.append(task)
        }
      }
    }
  }
}

private extension NBARRuschaDataModelImageRequest {
  private func beginBackgroundTask() {
    self.backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
      if let backgroundTask = self?.backgroundTask {
        UIApplication.shared.endBackgroundTask(backgroundTask)
      }
    }
  }
  
  private func endBackgroundTask() {
    if let backgroundTask = self.backgroundTask {
      UIApplication.shared.endBackgroundTask(backgroundTask)
    }
  }
}
