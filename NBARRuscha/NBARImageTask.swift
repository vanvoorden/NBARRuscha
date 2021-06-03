//
//  NBARImageTask.swift
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
import UIKit

func ImageTask(for string: String, completionHandler: @escaping (UIImage?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
  if let url = URL(string: string) {
    let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
    let task = URLSession.shared.dataTask(with: request) { result, response, error in
      if let error = error {
        completionHandler(nil, response, error)
      } else {
        if let response = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode),
           let mimeType = response.mimeType?.lowercased(),
           mimeType.contains("image"),
           let result = result {
          let image = UIImage(data: result)
          completionHandler(image, response, error)
        } else {
          completionHandler(nil, response, error)
        }
      }
    }
    
    task.resume()
    return task
  }
  
  return nil
}
