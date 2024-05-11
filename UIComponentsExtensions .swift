//
//  UIComponentsExtensions  .swift
//  Task25
//
//  Created by ana namgaladze on 10.05.24.
//

import UIKit

extension UIImageView {
    static func sfSymbolImageView(systemName: String, tintColor: UIColor = .white) -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        imageView.tintColor = tintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return imageView
    }
}

extension UIButton {
    static func sfSymbolButton(systemName: String, tintColor: UIColor = .systemGray) -> UIButton {
        let button = UIButton()
        button.tintColor = tintColor
        
        let image = UIImage(systemName: systemName)
        button.setImage(image, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 24),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return button
    }
}
