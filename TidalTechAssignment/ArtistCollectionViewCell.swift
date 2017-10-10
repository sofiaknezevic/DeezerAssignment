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
        contentView.addSubview(containerStackView)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configureCell(artist:DeezerArtist) {
        artistNameLabel.text = artist.artistName
        artistImageView.image = UIImage
    }
    
    //MARK: - Lazy Initializer Variables -
    //MARK: - Label
    private lazy var artistNameLabel:UILabel = {
        let artistNameLabel = UILabel()
        artistNameLabel.textColor = .white
        artistNameLabel.font = UIFont.systemFont(ofSize: 10)
        return artistNameLabel
    }()
    //MARK: - ImageView
    private lazy var artistImageView:UIImageView = {
        let artistImageView = UIImageView()
        return artistImageView
    }()
    //MARK: - Container StackView
    private lazy var containerStackView:UIStackView = {
        let containerStackView = UIStackView(arrangedSubviews: [self.artistImageView, self.artistNameLabel])
        containerStackView.axis = .horizontal
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 5
        return containerStackView
    }()
}
