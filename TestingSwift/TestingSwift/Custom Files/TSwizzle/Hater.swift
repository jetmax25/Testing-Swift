//
//  Hater.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/28/21.
//

import Foundation

struct Hater {
    var hating = false
    
    mutating func hadABadDay() {
        hating = true
    }
    
    mutating func hadAGoodDay() {
        hating = false
    }
}
