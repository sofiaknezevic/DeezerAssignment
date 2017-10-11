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
    
    init(albumArtistName:String, albumImageName:String?, albumName:String, albumID:NSNumber) {
        if let imageName = albumImageName {
            self.albumImageName = imageName
        }
        self.albumArtistName = albumArtistName
        self.albumName = albumName
        self.albumID = albumID
    }
    
}
