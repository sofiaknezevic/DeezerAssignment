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
    var trackDuration = TimeInterval()
    var trackPosition = NSNumber()
    
    init(trackName:String, trackDuration:TimeInterval, trackPosition:NSNumber) {
        self.trackName = trackName
        self.trackDuration = trackDuration
        self.trackPosition = trackPosition
    }
    
}
