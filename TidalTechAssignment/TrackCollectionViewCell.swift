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
        setConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configureCell(track:DeezerTrack) {
        trackNameLabel.text = track.trackName
        trackArtistNameLabel.text = track.trackArtistName
        trackDurationLabel.text = formatter.string(from: track.trackDuration)
        trackNumberLabel.text = String.init(format: "%@.", track.trackPosition)
    }
    private func setConstraints() {
        Utilities.constrainLeadingAndTrailing(childView: containerStackView, parentView: contentView, constant: 8)
        containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        //hot fix for now... didn't have time to look at this thoroughly
        trackNumberLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        trackDurationLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    //MARK: - Lazy Initializer Variables
    //MARK: - Date Formatter
    private lazy var formatter:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()
    //MARK: - Labels
    private lazy var trackNameLabel:UILabel = {
        let trackNameLabel = UILabel()
        trackNameLabel.textColor = .white
        trackNameLabel.font = UIFont.boldSystemFont(ofSize:10)
        trackNameLabel.numberOfLines = 0
        return trackNameLabel
    }()
    private lazy var trackArtistNameLabel:UILabel = {
        let artistNameLabel = UILabel()
        artistNameLabel.textColor = .lightGray
        artistNameLabel.font = UIFont.systemFont(ofSize: 8)
        artistNameLabel.numberOfLines = 0
        return artistNameLabel
    }()
    private lazy var trackDurationLabel:UILabel = {
        let trackDurationLabel = UILabel()
        trackDurationLabel.textColor = .lightGray
        trackDurationLabel.font = UIFont.systemFont(ofSize:8)
        return trackDurationLabel
    }()
    private lazy var trackNumberLabel:UILabel = {
        let trackNumberLabel = UILabel()
        trackNumberLabel.textColor = .white
        trackNumberLabel.font = UIFont.boldSystemFont(ofSize:10)
        return trackNumberLabel
    }()
    //MARK: - StackViews
    private lazy var centerLabelStackView:UIStackView = {
        let centerLabelStackView = UIStackView(arrangedSubviews: [self.trackNameLabel, self.trackArtistNameLabel])
        centerLabelStackView.axis = .vertical
        centerLabelStackView.alignment = .fill
        centerLabelStackView.distribution = .fill
        centerLabelStackView.spacing = 2
        return centerLabelStackView
    }()
    private lazy var containerStackView:UIStackView = {
        let containerStackView = UIStackView(arrangedSubviews: [self.trackNumberLabel, self.centerLabelStackView, self.trackDurationLabel])
        containerStackView.axis = .horizontal
        containerStackView.alignment = .center
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 5
        return containerStackView
    }()
}
