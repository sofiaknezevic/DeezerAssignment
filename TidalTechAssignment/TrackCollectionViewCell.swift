//
//  TrackCollectionViewCell.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class TrackCollectionViewCell: UICollectionViewCell {
 
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        contentView.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configureCell(track:DeezerTrack) {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [ .minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]
        
        
        trackNameLabel.text = track.trackName
        trackArtistNameLabel.text = track.trackArtistName
        trackDurationLabel.text = formatter.string(from: track.trackDuration)
        trackNumberLabel.text = String.init(format: "%@.", track.trackPosition)
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Labels
    private lazy var trackNameLabel:UILabel = {
        let trackNameLabel = UILabel()
        trackNameLabel.textColor = .white
        return trackNameLabel
    }()
    private lazy var trackArtistNameLabel:UILabel = {
        let artistNameLabel = UILabel()
        artistNameLabel.textColor = .white
        return artistNameLabel
    }()
    private lazy var trackDurationLabel:UILabel = {
        let trackDurationLabel = UILabel()
        trackDurationLabel.textColor = .white
        return trackDurationLabel
    }()
    private lazy var trackNumberLabel:UILabel = {
        let trackNumberLabel = UILabel()
        trackNumberLabel.textColor = .white
        return trackNumberLabel
    }()
    //MARK: - StackViews
    private lazy var centerLabelStackView:UIStackView = {
        let centerLabelStackView = UIStackView(arrangedSubviews: [self.trackNameLabel, self.trackArtistNameLabel])
        centerLabelStackView.axis = .vertical
        centerLabelStackView.alignment = .fill
        centerLabelStackView.distribution = .fillProportionally
        centerLabelStackView.spacing = 5
        return centerLabelStackView
    }()
    private lazy var containerStackView:UIStackView = {
        let containerStackView = UIStackView(arrangedSubviews: [self.trackNumberLabel, self.centerLabelStackView, self.trackDurationLabel])
        containerStackView.axis = .horizontal
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 5
        return containerStackView
    }()
}
