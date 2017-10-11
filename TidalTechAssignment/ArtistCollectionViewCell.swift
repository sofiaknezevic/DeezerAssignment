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
        contentView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        setConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configureCell(artist:DeezerArtist) {
        artistNameLabel.text = artist.artistName
        if let imageURL = URL.init(string: artist.artistImageName), let placeholderImage = UIImage.init(named: "placeholderArtistImage") {
            
            artistImageView.setImageWith(URLRequest.init(url: imageURL), placeholderImage: placeholderImage, success: { (request:URLRequest, response:HTTPURLResponse?, image:UIImage) in
                self.artistImageView.image = image
            }, failure: { (request:URLRequest, response:HTTPURLResponse?, error:Error) in
                
            })
        }
    }
    private func setConstraints() {
        //artistimageview
        artistImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        artistImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //containerstackview
        Utilities.constrainLeadingAndTrailing(childView: containerStackView, parentView: contentView, constant: 8)
        containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    //MARK: - Lazy Initializer Variables -
    //MARK: - Label
    private lazy var artistNameLabel:UILabel = {
        let artistNameLabel = UILabel()
        artistNameLabel.textColor = .white
        artistNameLabel.numberOfLines = 0
        return artistNameLabel
    }()
    //MARK: - ImageView
    private lazy var artistImageView:UIImageView = {
        let artistImageView = UIImageView()
        artistImageView.contentMode = .scaleAspectFill
        artistImageView.clipsToBounds = true
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
