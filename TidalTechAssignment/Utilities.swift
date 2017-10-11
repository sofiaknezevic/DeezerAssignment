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
