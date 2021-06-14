//
//  NBARJSONTask.swift
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

import Foundation

extension URLSession {
  func jsonTask(with request: URLRequest, completionHandler: @escaping (Any?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    let task = self.dataTask(with: request) { result, response, error in
      if let error = error {
        completionHandler(nil, response, error)
      } else {
        if let response = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode),
           let mimeType = response.mimeType,
           mimeType.lowercased().contains("json"),
           let result = result {
          do {
            let json = try JSONSerialization.jsonObject(with: result, options: [])
            completionHandler(json, response, error)
          } catch {
            completionHandler(nil, response, error)
          }
        } else {
          completionHandler(nil, response, error)
        }
      }
    }
    return task
  }
  
  func jsonTask(with string: String, completionHandler: @escaping (Any?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
    if let url = URL(string: string) {
      return self.jsonTask(with: url, completionHandler: completionHandler)
    }
    return nil
  }
  
  func jsonTask(with url: URL, completionHandler: @escaping (Any?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
    return self.jsonTask(with: request, completionHandler: completionHandler)
  }
}
