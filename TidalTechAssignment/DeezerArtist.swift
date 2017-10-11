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
    var artistImageName = String()
    var artistID = NSNumber()
    
    init(artistName:String?, artistImageName:String?, artistID:NSNumber?) {
        
        if let name = artistName, let imageName = artistImageName, let ID = artistID {
            self.artistName = name
            self.artistImageName = imageName
            self.artistID = ID
        }
    }
    
}
