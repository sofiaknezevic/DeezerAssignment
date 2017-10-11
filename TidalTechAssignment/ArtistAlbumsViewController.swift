//
//  ArtistAlbumsViewController.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class ArtistAlbumsViewController: UIViewController {

    private let albumTopBarView = TopBarView.init(frame: .zero)
    
    var albumsArray = [DeezerAlbum]()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(albumTopBarView)
        view.addSubview(albumCollectionView)
        
        setConstraints()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Initializers
    init(albumsArray:[DeezerAlbum], albumArtistName:String) {
        super.init(nibName: nil, bundle: nil)
        
        self.albumsArray = albumsArray
        
        albumTopBarView.configureView(topLabelText: albumArtistName, bottomLabelText: StringConstants.albumsLabelText)
        albumTopBarView.closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup & Configuration
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func setConstraints() {
        //albumtopbarview
        Utilities.constrainLeadingAndTrailing(childView: albumTopBarView, parentView: view, constant: 0)
        albumTopBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        albumTopBarView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: SizeConstants.barHeightMultipler).isActive = true
        
        //albumcollectionview
        Utilities.constrainLeadingAndTrailing(childView: albumCollectionView, parentView: view, constant: 0)
        albumCollectionView.topAnchor.constraint(equalTo: albumTopBarView.bottomAnchor).isActive = true
        albumCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Album CollectionView
    lazy var albumCollectionView:UICollectionView = {
        let albumCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        albumCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        
        albumCollectionView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        albumCollectionView.allowsSelection = true
        
        albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: StringConstants.albumCellIdentifier)
        return albumCollectionView
    }()
}

//MARK: - Extensions
//MARK: - UICollectionView Delegate & DataSource
extension ArtistAlbumsViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var albumTracks = [DeezerTrack]()
        
        let retrieveTracksGroup = DispatchGroup()
        retrieveTracksGroup.enter()
        
        DeezerManager.retrieveAlbumTracks(album: albumsArray[indexPath.item]) { (trackArray:[DeezerTrack]?, error:Error?) in
            if ((error) != nil) {
                SVProgressHUD.showError(withStatus: StringConstants.fetchRequestErrorTitle)
            } else {
                if let tracks = trackArray {
                    albumTracks = tracks
                }
            }
            retrieveTracksGroup.leave()
        }
        retrieveTracksGroup.notify(queue: DispatchQueue.main) { 
            let tracksViewController = AlbumTracksViewController.init(trackArray: albumTracks, trackArtistName: self.albumsArray[indexPath.item].albumArtistName, trackAlbumName: self.albumsArray[indexPath.item].albumName)
            
            let cell = collectionView.cellForItem(at: indexPath) as! AlbumCollectionViewCell
            tracksViewController.trackAlbumImageView.image = cell.albumImageView.image
            
            self.present(tracksViewController, animated: true, completion: nil)
        }
    }
}
extension ArtistAlbumsViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.albumCellIdentifier, for: indexPath) as! AlbumCollectionViewCell
        cell.configureCell(album: albumsArray[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionView Flow Layout
extension ArtistAlbumsViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width/2), height: (collectionView.bounds.width/2))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
