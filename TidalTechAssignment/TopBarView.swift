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
    let searchIconImageView = UIImageView()
    let searchIconContainerView = UIView()
    
    let topLabel = UILabel()
    let bottomLabel = UILabel()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerStackView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Stack View
    private lazy var containerStackView:UIStackView = {
        let containerStackView = UIStackView()
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
