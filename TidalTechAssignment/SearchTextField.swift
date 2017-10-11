//
//  SearchTextField.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-11.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class SearchTextField: UITextField {

    override func layoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
