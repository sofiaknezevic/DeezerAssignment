//
//  DeezerArtist.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-09.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class DeezerArtist: NSObject {
    
    var artistName = String()
    var imageName = String()
    
    init(artistName:String, imageName:String) {
        self.artistName = artistName
        self.imageName = imageName
    }
    
}
