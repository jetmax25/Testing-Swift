//
//  MainCoordinator.swift
//  TDD
//
//  Created by Michael Isasi on 4/30/21.
//

import Foundation
import UIKit

class MainCoordinator {
    var navigationController = UINavigationController()
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let viewController = storyboard.instantiateInitialViewController() as? ViewController else {
            fatalError("Missing initial view controller in Main.storyboard")
        }
        
        viewController.pictureSelectAction = { [weak self] in
            self?.showDetail(for: $0)
        }
        
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func showDetail(for fileName: String) {
        let vc = DetailViewController()
        vc.selectedImage = fileName
        
        navigationController.pushViewController(vc, animated: true)
    }
}
