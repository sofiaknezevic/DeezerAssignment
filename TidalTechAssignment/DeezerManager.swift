//
//  DeezerManager.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-07.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class DeezerManager: NSObject {
    
    public typealias SearchArtistsCompletionBlock = ([DeezerArtist]?, Error?) -> Void
    
    class func searchForArtist(artists:[DeezerArtist], searchString:String, completionHandler:@escaping SearchArtistsCompletionBlock) {
        var artistArray = artists
        var request:URLRequest?
        
        if let searchURL = URL.init(string: String.init(format: "https://api.deezer.com/search/artist?q=%@", searchString)) {
            request = URLRequest.init(url: searchURL)
        }
        
        request?.httpMethod = "GET"
        

        URLSession.shared.dataTask(with: request!) { (data:Data?, response:URLResponse?, error:Error?) in

            let returnDictionary:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            let artistDictArray = returnDictionary.object(forKey: "data") as! [NSDictionary]
            
            for deezerArtistDict in artistDictArray {
                let deezerArtistName = deezerArtistDict.object(forKey: "name") as! String
                let deezerImageName = deezerArtistDict.object(forKey: "picture") as! String
                let newArtist = DeezerArtist.init(artistName: deezerArtistName, imageName: deezerImageName)
                
                if !(artistArray.contains(newArtist)) {
                    artistArray.append(newArtist)
                }
            }
            
            completionHandler(artistArray, error)
            
        }.resume()

    }
    

}
