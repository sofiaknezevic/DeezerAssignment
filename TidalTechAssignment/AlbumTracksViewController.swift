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
        trackAlbumImageView.translatesAutoresizingMaskIntoConstraints = false
        trackTopBarView.closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(trackTopBarView)
        view.addSubview(trackAlbumImageView)
        view.addSubview(trackCollectionView)
        
        trackTopBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        trackTopBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackTopBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackTopBarView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        trackAlbumImageView.topAnchor.constraint(equalTo: trackTopBarView.bottomAnchor).isActive = true
        trackAlbumImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackAlbumImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackAlbumImageView.heightAnchor.constraint(equalTo: trackAlbumImageView.widthAnchor).isActive = true
        
        trackCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trackCollectionView.topAnchor.constraint(equalTo: trackAlbumImageView.bottomAnchor).isActive = true
        trackCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Initializers
    init(trackArray:[DeezerTrack], trackArtistName:String, trackAlbumName:String) {
        super.init(nibName: nil, bundle: nil)
        self.trackArray = trackArray
        trackTopBarView.configureView(topLabelText: trackAlbumName, bottomLabelText: trackArtistName)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Album Image View
    lazy var trackAlbumImageView:UIImageView = {
        let trackAlbumImageView = UIImageView()
        trackAlbumImageView.contentMode = .scaleAspectFill
        trackAlbumImageView.clipsToBounds = true
        return trackAlbumImageView
    }()
    //MARK: - Track CollectionView
    lazy var trackCollectionView:UICollectionView = {
        let trackCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        trackCollectionView.translatesAutoresizingMaskIntoConstraints = false
        trackCollectionView.delegate = self
        trackCollectionView.dataSource = self
        trackCollectionView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        trackCollectionView.allowsSelection = true
        trackCollectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: "trackCollectionViewCell")
        return trackCollectionView
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCollectionViewCell", for: indexPath) as! TrackCollectionViewCell
        cell.configureCell(track: trackArray[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionView Delegate Flow Layout
extension AlbumTracksViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: (collectionView.bounds.width)/10)
    }
}
