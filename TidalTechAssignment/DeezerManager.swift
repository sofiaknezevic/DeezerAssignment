//
//  DeezerManager.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-07.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class DeezerManager: NSObject {
    
    public typealias SearchArtistsCompletionBlock = (NSArray?, Error?) -> Void
    
    class func searchForArtist(searchString:String, completionHandler:@escaping SearchArtistsCompletionBlock) {
        
        var request:URLRequest?
        
        if let searchURL = URL.init(string: String.init(format: "https://api.deezer.com/search/artist?q=%@", searchString)) {
            request = URLRequest.init(url: searchURL)
        }
        
        request?.httpMethod = "GET"
        

        URLSession.shared.dataTask(with: request!) { (data:Data?, response:URLResponse?, error:Error?) in
            
            let returnDictionary:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            let artistArray = returnDictionary.object(forKey: "data")
            completionHandler(artistArray as! NSArray?, error)
           // print(returnDictionary)
            
        }.resume()

    }
    

}
