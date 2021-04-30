//
//  PreConUser.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/29/21.
//

import Foundation

class PreConUser {
    
}

class PreConStore {
    var user: PreConUser?
    
    func buy(product: String) -> Bool {
        assert(user != nil, "We can't buy anything without a user.")
        print("The user bought \(product)")
        return true
    }
}
