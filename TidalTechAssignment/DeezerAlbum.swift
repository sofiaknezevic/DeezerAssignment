//
//  DeezerAlbum.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class DeezerAlbum: NSObject {

    var albumArtistName = String()
    var albumImageName = String()
    var albumName = String()
    var albumID = NSNumber()
    
    init(albumArtistName:String?, albumImageName:String?, albumName:String?, albumID:NSNumber?) {
        if let artistName = albumArtistName, let imageName = albumImageName, let name = albumName, let ID = albumID{
            self.albumArtistName = artistName
            self.albumImageName = imageName
            self.albumName = name
            self.albumID = ID
        }
    }
    
}
