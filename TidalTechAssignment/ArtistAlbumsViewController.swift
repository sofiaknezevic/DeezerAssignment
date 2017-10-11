//
//  ArtistAlbumsViewController.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-10.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class ArtistAlbumsViewController: UIViewController {

    let albumTopBarView = TopBarView.init(frame: .zero)
    var albumsArray = [DeezerAlbum]()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        albumTopBarView.translatesAutoresizingMaskIntoConstraints = false
        albumTopBarView.closeButton.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(albumTopBarView)
        view.addSubview(albumCollectionView)
        
        
        
        albumTopBarView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        albumTopBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        albumTopBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        albumTopBarView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        albumCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        albumCollectionView.topAnchor.constraint(equalTo: albumTopBarView.bottomAnchor).isActive = true
        albumCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        albumCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Initializers
    init(albumsArray:[DeezerAlbum], albumArtistName:String) {
        super.init(nibName: nil, bundle: nil)
        self.albumsArray = albumsArray
        albumTopBarView.configureView(topLabelText: albumArtistName, bottomLabelText: "Albums")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "albumCollectionViewCell")
        return albumCollectionView
    }()
}

//MARK: - Extensions
//MARK: - UICollectionView Delegate & DataSource
extension ArtistAlbumsViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var albumTracks = [DeezerTrack]()
        let group = DispatchGroup()
        group.enter()
        DeezerManager.retrieveAlbumTracks(album: albumsArray[indexPath.item]) { (trackArray:[DeezerTrack]?, error:Error?) in
            if let tracks = trackArray {
                albumTracks = tracks
            }
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) { 
            
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        cell.configureCell(album: albumsArray[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionView Flow Layout
extension ArtistAlbumsViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width/2), height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
