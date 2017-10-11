//
//  AlbumTracksViewController.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class AlbumTracksViewController: UIViewController {

    private let trackTopBarView = TopBarView.init(frame: .zero)
    
    var trackArray = [DeezerTrack]()
    var sections = 0
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    
        view.addSubview(trackTopBarView)
        view.addSubview(trackAlbumImageView)
        view.addSubview(trackCollectionView)
        
        setConstraints()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Initializers
    init(trackArray:[DeezerTrack], trackArtistName:String, trackAlbumName:String, albumImage:UIImage?) {
        super.init(nibName: nil, bundle: nil)
        
        self.trackArray = trackArray
        trackTopBarView.configureView(topLabelText: trackAlbumName, bottomLabelText: trackArtistName)
        trackTopBarView.closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        
        if let image = albumImage {
            trackAlbumImageView.image = image
        }
        
        numberOfDiscs()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup & Configuration
    private func setConstraints() {
        //topbarview
        Utilities.constrainLeadingAndTrailing(childView: trackTopBarView, parentView: view, constant: 0)
        trackTopBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        trackTopBarView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: SizeConstants.barHeightMultipler).isActive = true
        
        //trackalbumimageview
        Utilities.constrainLeadingAndTrailing(childView: trackAlbumImageView, parentView: view, constant: 0)
        trackAlbumImageView.topAnchor.constraint(equalTo: trackTopBarView.bottomAnchor).isActive = true
        trackAlbumImageView.heightAnchor.constraint(equalTo: trackAlbumImageView.widthAnchor).isActive = true
        
        //trackcollectionview
        Utilities.constrainLeadingAndTrailing(childView: trackCollectionView, parentView: view, constant: 0)
        trackCollectionView.topAnchor.constraint(equalTo: trackAlbumImageView.bottomAnchor).isActive = true
        trackCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Helpers
    private func numberOfDiscs() {
        for track in trackArray {
            if track.trackPosition.intValue == 1 {
                sections = sections+1
            }
        }
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Album Image View
    private lazy var trackAlbumImageView:UIImageView = {
        let trackAlbumImageView = UIImageView()
        trackAlbumImageView.contentMode = .scaleAspectFill
        trackAlbumImageView.clipsToBounds = true
        return trackAlbumImageView
    }()
    //MARK: - Track CollectionView
    lazy var trackCollectionView:UICollectionView = {
        let trackCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        trackCollectionView.delegate = self
        trackCollectionView.dataSource = self
        
        trackCollectionView.backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
        trackCollectionView.allowsSelection = true
        
        trackCollectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: StringConstants.trackCellIdentifier)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.trackCellIdentifier, for: indexPath) as! TrackCollectionViewCell
        cell.configureCell(track: trackArray[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionView Delegate Flow Layout
extension AlbumTracksViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: (collectionView.bounds.width)/10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
