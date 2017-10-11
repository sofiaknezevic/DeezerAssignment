//
//  DeezerTrack.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class DeezerTrack: NSObject {
    
    var trackName = String()
    var trackArtistName = String()
    var trackDuration = TimeInterval()
    var trackPosition = NSNumber()
    var trackDiskNumber = NSNumber()
    
    init(trackName:String?, trackArtistName:String?, trackDuration:TimeInterval?, trackPosition:NSNumber?, trackDiskNumber:NSNumber?) {
        if let name = trackName, let artistName = trackArtistName, let duration = trackDuration, let position = trackPosition, let diskNumber = trackDiskNumber {
            self.trackName = name
            self.trackArtistName = artistName
            self.trackDuration = duration
            self.trackPosition = position
            self.trackDiskNumber = diskNumber
        }
    }
    
}
