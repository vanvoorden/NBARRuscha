//
//  NBARNetworkResponse.swift
//  NBNetworking
//
//  Created by Rick Van Voorden on 6/8/21.
//

import Foundation

struct NBARNetworkResponse {
  let data: Foundation.Data?
  let response: Foundation.URLResponse?
  let error: Swift.Error?
}
