//
//  Utilities.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
}

//MARK: - Extensions - 
//MARK: - String
extension String {
    func trimmedStringForURL(urlString:String) -> String {
        var trimmedString = String()
        
        if let urlEncodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            trimmedString = urlEncodedString
        }
        trimmedString = trimmedString.replacingOccurrences(of: "&", with: "%20%26")
        
        return trimmedString
    }
}

//MARK: - Button
extension UIButton {
    func constrainIconButton(iconButton:UIButton) {
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.widthAnchor.constraint(equalTo: iconButton.heightAnchor).isActive = true
        
        if let iconButtonImageView = iconButton.imageView {
            iconButtonImageView.contentMode = .scaleAspectFit
            iconButtonImageView.translatesAutoresizingMaskIntoConstraints = false
            
            iconButtonImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            iconButtonImageView.widthAnchor.constraint(equalTo: iconButtonImageView.heightAnchor).isActive = true
        }
    }
}

//MARK: - UIImageView
extension UIImageView {
    func constrainIconImageView(imageView:UIImageView, to containerView:UIView) {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier:2).isActive = true
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier:2).isActive = true
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
}
