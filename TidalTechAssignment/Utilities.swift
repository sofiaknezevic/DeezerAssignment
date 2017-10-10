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
        
        trimmedString = urlString.replacingOccurrences(of: " ", with: "%20")
        if urlString.contains("&") {

        }
        trimmedString = urlString.replacingOccurrences(of: "&", with: "%26")
        
        return trimmedString
    }
}
