//
//  AlbumCollectionViewCell.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerStackView)
//        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
//        albumImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        albumImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configureCell(album:DeezerAlbum) {
        albumArtistNameLabel.text = album.albumArtistName
        albumNameLabel.text = album.albumName
        if let imageURL = URL.init(string: album.albumImageName) {
            
            albumImageView.setImageWith(URLRequest.init(url: imageURL), placeholderImage: nil, success: { (request:URLRequest, response:HTTPURLResponse?, image:UIImage) in
                //do I need to make this a weak self pointer?
                self.albumImageView.image = image
            }, failure: { (request:URLRequest, response:HTTPURLResponse?, error:Error) in
                
            })
        }
    }
    
    
    //MARK: - Lazy Initializer Variables -
    //MARK: - Label
    private lazy var albumArtistNameLabel:UILabel = {
        let albumArtistNameLabel = UILabel()
        albumArtistNameLabel.textColor = .white
        albumArtistNameLabel.font = UIFont.systemFont(ofSize: 20)
        return albumArtistNameLabel
    }()
    private lazy var albumNameLabel:UILabel = {
        let albumNameLabel = UILabel()
        albumNameLabel.textColor = .white
        albumNameLabel.font = UIFont.systemFont(ofSize: 20)
        return albumNameLabel
    }()
    //MARK: - ImageView
    private lazy var albumImageView:UIImageView = {
        let albumImageView = UIImageView()
        albumImageView.contentMode = .scaleAspectFill
        albumImageView.clipsToBounds = true
        return albumImageView
    }()
    //MARK: - Container StackView
    private lazy var containerStackView:UIStackView = {
        let containerStackView = UIStackView(arrangedSubviews: [self.albumImageView, self.albumNameLabel, self.albumArtistNameLabel])
        containerStackView.axis = .vertical
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 5
        return containerStackView
    }()
    
}
