//
//  URLHandler.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/29/21.
//

import Foundation
import UIKit

typealias URLOpening = (URL, [UIApplication.OpenExternalURLOptionsKey: Any], ((Bool) -> Void)?) -> Void
struct URLHandler {
    
    let urlOpener: URLOpening
    
    init(urlOpener: @escaping URLOpening = UIApplication.shared.open) {
        self.urlOpener = urlOpener
    }
    
    func open(url: URL) {
        if url.absoluteString.hasPrefix("internal://") {
            
        } else {
            urlOpener(url, [:], nil)
        }
    }
}
