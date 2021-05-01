//
//  User.swift
//  TDD
//
//  Created by Michael Isasi on 4/30/21.
//

import Foundation

struct User {
    var products = Set<String>()
    
    mutating func buy(_ product: String) {
        products.insert(product)
    }
    
    func owns(_ product: String) -> Bool {
        return product.contains(product)
    }
}
