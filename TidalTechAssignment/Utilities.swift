//
//  Utilities.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    class func constrainToAllSides(childView:UIView, parentView:UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        childView.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
    }

    class func constrainLeadingAndTrailing(childView:UIView, parentView:UIView, constant:CGFloat) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant:constant).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant:-constant).isActive = true
    }
}

//MARK: - Structs -
//MARK: - Sizes
struct SizeConstants {
    
    private init() {}
    
    static let iconImageHeight = CGFloat.init(15)
}
//MARK: - Strings
struct StringConstants {
    
    private init() {}
    
    static let artistSectionText = "ARTISTS"
    
    static let microphoneImageName = "microphone"
    static let clearIconImageName = "clearIcon"
    static let moreMenuIconImageName = "moreMenuIcon"
    static let searchIconImageName = "searchIcon"
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
        if let iconButtonImageView = iconButton.imageView {
            iconButtonImageView.contentMode = .scaleAspectFit
            iconButtonImageView.translatesAutoresizingMaskIntoConstraints = false
            
            iconButtonImageView.heightAnchor.constraint(equalToConstant: SizeConstants.iconImageHeight).isActive = true
            iconButtonImageView.widthAnchor.constraint(equalTo: iconButtonImageView.heightAnchor).isActive = true
        }
        iconButton.translatesAutoresizingMaskIntoConstraints = false
        iconButton.widthAnchor.constraint(equalTo: iconButton.heightAnchor).isActive = true
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
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
}

//MARK: - UIViewController
extension UIViewController {
    func dismissSelf () {
        dismiss(animated: true, completion: nil)
    }
}

