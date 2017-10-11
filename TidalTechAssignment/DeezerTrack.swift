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
    
    init(trackName:String, trackArtistName:String, trackDuration:TimeInterval, trackPosition:NSNumber, trackDiskNumber:NSNumber) {
        self.trackName = trackName
        self.trackArtistName = trackArtistName
        self.trackDuration = trackDuration
        self.trackPosition = trackPosition
        self.trackDiskNumber = trackDiskNumber
    }
    
}
