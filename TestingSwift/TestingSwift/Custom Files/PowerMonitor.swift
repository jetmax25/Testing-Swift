//
//  PowerMonitor.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/29/21.
//

import Foundation
import UIKit

struct PowerMonitor {
    var device: UIDevice
    
    func getStatus() -> String {
        switch device.batteryState {
        case .unplugged: return "Power is down"
        case .unknown: return "Error"
        default: return "Power is up"
        }
    }
}
