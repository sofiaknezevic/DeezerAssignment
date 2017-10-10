//
//  ArtistCollectionViewCell.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-09.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Configuration
    func configureCell(artist:DeezerArtist) {
        artistNameLabel.text = artist.artistName
    }
    
    //MARK: - Lazy Initializer Variables
    private lazy var artistNameLabel:UILabel = {
        let artistNameLabel = UILabel()
        artistNameLabel.textColor = .white
        artistNameLabel.font = UIFont.systemFont(ofSize: 10)
        return artistNameLabel
    }()
}
