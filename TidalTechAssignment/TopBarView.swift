//
//  TopBarView.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    
    private let moreMenuButton = UIButton()
    let closeButton = UIButton()
    
    private let searchIconImageView = UIImageView()
    private let searchIconContainerView = UIView()
    
    private let topLabel = UILabel()
    private let bottomLabel = UILabel()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
        
        topLabel.textColor = .white
        bottomLabel.textColor = .lightGray
        
        topLabel.font = UIFont.boldSystemFont(ofSize: 10)
        bottomLabel.font = UIFont.systemFont(ofSize: 8)
        
        searchIconContainerView.addSubview(searchIconImageView)
        addSubview(containerStackView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    func configureView(topLabelText:String, bottomLabelText:String) {
        topLabel.text = topLabelText
        bottomLabel.text = bottomLabelText
    }
    private func setSubviewImages() {
        moreMenuButton.setImage(UIImage.init(named: StringConstants.moreMenuIconImageName), for: .normal)
        closeButton.setImage(UIImage.init(named: StringConstants.clearIconImageName), for: .normal)
        searchIconImageView.image = UIImage.init(named: StringConstants.searchIconImageName)
    }
    private func setConstraints() {
        //buttons
        moreMenuButton.constrainIconButton(iconButton: moreMenuButton)
        closeButton.constrainIconButton(iconButton: closeButton)
        
        //searchiconimageview
        searchIconImageView.constrainIconImageView(imageView: searchIconImageView, to: searchIconContainerView)
        
        //containerstackview
        Utilities.constrainToAllSides(childView: containerStackView, parentView: self)
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
