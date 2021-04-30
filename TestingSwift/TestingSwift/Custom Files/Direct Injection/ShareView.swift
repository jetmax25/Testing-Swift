//
//  ShareView.swift
//  TestingSwift
//
//  Created by Michael Isasi on 4/29/21.
//

import Foundation
import UIKit

class ShareView: UIView {
    var shareAction: (String) -> Void
    var textField: UITextField!
    
    init(shareAction: @escaping (String) -> Void ) {
        self.shareAction = shareAction
        super.init(frame: .zero)
        
        let textField = UITextField()
        addSubview(textField)
    
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func shareTapped() {
        guard let text = textField.text else { return }
        shareAction(text)
    }
}

class ShareViewController: UIViewController {
    override func loadView() {
        view = ShareView { [weak self] in
            self?.shareContent(text: $0)
        }
    }
    
    func shareContent(text: String) {
        print("Sharing Text...")
    }
}
