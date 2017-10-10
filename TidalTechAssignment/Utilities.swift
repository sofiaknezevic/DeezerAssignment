//
//  Utilities.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    class func deezerPlaceholderImage() -> UIImage? {
        let containerImageView = UIImageView()
        if let placeholderImageURL = URL.init(string: "https://api.deezer.com/artist/12641945/image") {
            containerImageView.setImageWith(placeholderImageURL)
        }
        return containerImageView.image
    }
    
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
