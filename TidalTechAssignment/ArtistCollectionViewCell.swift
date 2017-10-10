//
//  ArtistCollectionViewCell.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-09.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class ArtistCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
