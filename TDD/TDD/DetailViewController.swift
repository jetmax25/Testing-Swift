//
//  DetailViewController.swift
//  TDD
//
//  Created by Michael Isasi on 4/30/21.
//

import UIKit

class DetailViewController: UIViewController {

    let imageView = UIImageView()
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        view = imageView
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
}
