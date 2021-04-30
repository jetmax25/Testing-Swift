//
//  Buyer.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/29/21.
//

import Foundation
class Buyer {
    func view<T: HouseProtocol>(_ house: T) {
        house.conductViewing()
    }
}

protocol HouseProtocol {
    var numberOfViewings: Int { get set }
    func conductViewing()
}

class House: HouseProtocol {
    var numberOfViewings = 0
    
    func conductViewing() {
        numberOfViewings += 1
    }
}
