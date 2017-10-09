//
//  SearchArtistsViewController.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-07.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class SearchArtistsViewController: UIViewController {

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setUpView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup & Configuration
    private func setUpView() {
        view.backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Lazy Initializer Variables
//    private lazy var searchBarContainerStack:UIStackView = {
//        
//    }()
}
