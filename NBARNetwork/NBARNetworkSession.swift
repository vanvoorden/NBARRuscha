//
//  NBARNetworkSession.swift
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

protocol NBARNetworkSessionURLSessionDataTask {
  func cancel()
  func resume()
  func suspend()
}

protocol NBARNetworkSessionURLSession {
  associatedtype DataTask : NBARNetworkSessionURLSessionDataTask
  associatedtype URLSession : NBARNetworkSessionURLSession
  
  static var shared: Self.URLSession { get }
  
  typealias CompletionHandler = @Sendable (Foundation.Data?, Foundation.URLResponse?, Swift.Error?) -> Swift.Void
  
  func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler) -> Self.DataTask
}

struct NBARNetworkSession<URLSession> where URLSession : NBARNetworkSessionURLSession {
  typealias CompletionHandler = (NBARNetworkResponse) -> Swift.Void
  static func dataTask(with request: Foundation.URLRequest, completionHandler: @escaping Self.CompletionHandler) -> URLSession.URLSession.DataTask {
    return URLSession.shared.dataTask(with: request) { data, response, error in
      let response = NBARNetworkResponse(data: data, response: response, error: error)
      completionHandler(response)
    }
  }
}
