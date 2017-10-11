//
//  TopBarView.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    
    let moreMenuButton = UIButton()
    let closeButton = UIButton()
    let searchIconImageView = UIImageView()
    let searchIconContainerView = UIView()
    
    let topLabel = UILabel()
    let bottomLabel = UILabel()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
        
        topLabel.textColor = .white
        bottomLabel.textColor = .white
        
        moreMenuButton.setImage(UIImage.init(named: "moreMenuIcon"), for: .normal)
        closeButton.setImage(UIImage.init(named: "clearIcon"), for: .normal)
        searchIconImageView.image = UIImage.init(named: "searchIcon")
        searchIconContainerView.addSubview(searchIconImageView)
        moreMenuButton.constrainIconButton(iconButton: moreMenuButton)
        closeButton.constrainIconButton(iconButton: closeButton)
        searchIconImageView.constrainIconImageView(imageView: searchIconImageView, to: searchIconContainerView)
        
        addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configureView(topLabelText:String, bottomLabelText:String) {
        topLabel.text = topLabelText
        bottomLabel.text = bottomLabelText
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Stack View
    private lazy var containerStackView:UIStackView = {
        let containerStackView = UIStackView(arrangedSubviews: [self.closeButton, self.moreMenuButton, self.labelStackView, self.searchIconContainerView])
        containerStackView.axis = .horizontal
        containerStackView.alignment = .fill
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = 5
        return containerStackView
    }()
    private lazy var labelStackView:UIStackView = {
        let labelStackView = UIStackView(arrangedSubviews: [self.topLabel, self.bottomLabel])
        labelStackView.axis = .vertical
        labelStackView.alignment = .fill
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 5
        return labelStackView
    }()

}
