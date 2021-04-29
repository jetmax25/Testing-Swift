//
//  LinkedInUser.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/29/21.
//

import Foundation

struct LinkedInUser {
    static let upgradedNotification = Notification.Name("UserUpgraded")
    
    func upgrade(using center: NotificationCenter = .default) {
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            center.post(name: LinkedInUser.upgradedNotification, object: nil, userInfo: [LinkedInUser.Level.key: Level.gold])
        }
    }
}

extension LinkedInUser {

    enum Level {
        static let key = "Level"
        
        case gold
        case silver
        case bronze
    }
}
