//
//  AlbumTracksViewController.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class AlbumTracksViewController: UIViewController {

    let trackTopBarView = TopBarView.init(frame: .zero)
    var trackArray = [DeezerTrack]()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        trackTopBarView.translatesAutoresizingMaskIntoConstraints = false
        trackTopBarView.closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(trackTopBarView)
        view.addSubview(albumCollectionView)
        
        
        
        trackTopBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        trackTopBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackTopBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackTopBarView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        albumCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        albumCollectionView.topAnchor.constraint(equalTo: trackTopBarView.bottomAnchor).isActive = true
        albumCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        albumCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Initializers
    init(trackArray:[DeezerTrack], trackArtistName:String) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Track CollectionView
    lazy var albumCollectionView:UICollectionView = {
        let albumCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        albumCollectionView.translatesAutoresizingMaskIntoConstraints = false
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        albumCollectionView.allowsSelection = true
        albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "albumCollectionViewCell")
        return albumCollectionView
    }()
}

//MARK: - Extensions
//MARK: - UICollectionView Delegate & DataSource
extension AlbumTracksViewController:UICollectionViewDelegate {
    
}
extension AlbumTracksViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}
