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
    public typealias RetrieveArtistAlbumsCompletionBlock = ([DeezerAlbum]?, Error?) -> Void
    
    class func searchForArtist(artists:[DeezerArtist], searchString:String, completionHandler:@escaping SearchArtistsCompletionBlock) {
        var artistArray = artists
        var request:URLRequest?
        let trimmedString = searchString.trimmedStringForURL(urlString: searchString)
        
        if let searchURL = URL.init(string: String.init(format: "https://api.deezer.com/search/artist?q=%@", trimmedString)) {
            request = URLRequest.init(url: searchURL)
        }
        
        request?.httpMethod = "GET"
        
        if let searchRequest = request {
            URLSession.shared.dataTask(with: searchRequest) { (data:Data?, response:URLResponse?, error:Error?) in
                if let jsonData = data {
                    let returnDictionary:NSDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! NSDictionary
                    let artistDictArray = returnDictionary.object(forKey: "data") as! [NSDictionary]
                    
                    for deezerArtistDict in artistDictArray {
                        let deezerArtistName = deezerArtistDict.object(forKey: "name") as! String
                        let deezerArtistImageName = deezerArtistDict.object(forKey: "picture") as! String
                        let deezerArtistID = deezerArtistDict.object(forKey: "id") as! NSNumber
                        let newArtist = DeezerArtist.init(artistName: deezerArtistName, artistImageName: deezerArtistImageName, artistID: deezerArtistID)
                        
                        if !(artistArray.contains(newArtist)) {
                            artistArray.append(newArtist)
                        }
                    }
                    
                    completionHandler(artistArray, error)
                }
                
            }.resume()
        }

    }
    
    class func retrieveArtistAlbums(artist:DeezerArtist, completionHandler:@escaping RetrieveArtistAlbumsCompletionBlock) {
        var albumArray = [DeezerAlbum]()
        var request:URLRequest?
        if let retrieveAlbumsURL = URL.init(string: String.init(format: "https://api.deezer.com/artist/%@/albums", artist.artistID)) {
            request = URLRequest.init(url: retrieveAlbumsURL)
        }
        
        request?.httpMethod = "GET"
        
        if let retrieveAlbumRequest = request {
            URLSession.shared.dataTask(with: retrieveAlbumRequest, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                if let jsonData = data {
                    let returnDictionary:NSDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! NSDictionary
                    let albumDictArray = returnDictionary.object(forKey: "data") as! [NSDictionary]
                    
                    for deezerAlbumDict in albumDictArray {
                        let deezerAlbumName = deezerAlbumDict.object(forKey: "name") as! String
                        let deezerAlbumImagename = deezerAlbumDict.object(forKey: "picture") as! String
                        let deezerAlbumID = deezerAlbumDict.object(forKey: "id") as! NSNumber
                        let newAlbum = DeezerAlbum.init(albumArtistName: artist.artistName, albumImageName: deezerAlbumImagename, albumName: deezerAlbumName, albumID: deezerAlbumID)
                        albumArray.append(newAlbum)
                    }
                    
                    completionHandler(albumArray, error)
                }
                
            }).resume()
        }
    }
    

}
