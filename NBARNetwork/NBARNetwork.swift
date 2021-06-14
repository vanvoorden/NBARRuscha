//
//  NBARNetwork.swift
//  NBARRuscha
//
//  Created by Rick Van Voorden on 6/13/21.
//

import Foundation
import UIKit

extension Foundation.JSONSerialization : NBARNetworkJSONHandlerJSONSerialization {
  
}

extension Foundation.URLSession : NBARNetworkSessionURLSession {
  
}

extension Foundation.URLSessionDataTask : NBARNetworkSessionDataTask {
  
}

extension UIKit.UIImage : NBARNetworkImageSerializationImage {
  
}

