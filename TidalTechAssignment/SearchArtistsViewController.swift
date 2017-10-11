//
//  SearchArtistsViewController.swift
//  TidalTechAssignment
//
//  Created by Sofia Knezevic on 2017-10-07.
//  Copyright © 2017 Sofia Knezevic. All rights reserved.
//

import UIKit

class SearchArtistsViewController: UIViewController {
    
    var artistArray = [DeezerArtist]()
    
    let artistSectionImageView = UIImageView()
    let artistSectionLabel = UILabel()
    
    let searchIconImageView = UIImageView()

    let clearButton = UIButton()
    let moreButton = UIButton()
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Setup & Configuration
    private func setUpView() {
        
        view.addSubview(searchBarContainerView)
        view.addSubview(artistSectionContainerView)
        view.addSubview(artistCollectionView)
        view.backgroundColor = .black
        
        setSubviewImages()
        setSubviewProperties()
        setConstraints()
    }
    func setSubviewImages() {
        artistSectionImageView.image = UIImage.init(named: StringConstants.microphoneImageName)
        searchIconImageView.image = UIImage.init(named: StringConstants.searchIconImageName)
        clearButton.setImage(UIImage.init(named: StringConstants.clearIconImageName), for: .normal)
        moreButton.setImage(UIImage.init(named: StringConstants.moreMenuIconImageName), for: .normal)
    }
    func setSubviewProperties() {
        artistSectionLabel.text = StringConstants.artistSectionText
        artistSectionLabel.textColor = .white
        
        clearButton.addTarget(self, action: #selector(clearSearchTextField), for: .touchUpInside)
    }
    func setConstraints() {
        searchIconImageView.constrainIconImageView(imageView: searchIconImageView, to: searchIconContainerView)
        Utilities.constrainLeadingAndTrailing(childView: searchBarContainerView, parentView: view, constant: 0)
        searchBarContainerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        searchBarContainerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        
        Utilities.constrainLeadingAndTrailing(childView: artistSectionContainerView, parentView: view, constant: 0)
        artistSectionContainerView.topAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        artistSectionContainerView.heightAnchor.constraint(equalTo: searchBarContainerView.heightAnchor).isActive = true
        
        
        artistSectionImageView.constrainIconImageView(imageView: artistSectionImageView, to: artistImageContainerView)
        Utilities.constrainToAllSides(childView: artistSectionStackView, parentView: artistSectionContainerView)
        moreButton.constrainIconButton(iconButton: moreButton)
        clearButton.constrainIconButton(iconButton: clearButton)
        Utilities.constrainLeadingAndTrailing(childView: searchBarStackView, parentView: searchBarContainerView, constant: 8)
        searchBarStackView.topAnchor.constraint(equalTo: searchBarContainerView.topAnchor, constant: 8).isActive = true
        searchBarStackView.bottomAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        
        Utilities.constrainLeadingAndTrailing(childView: artistCollectionView, parentView: view, constant: 0)
        artistCollectionView.topAnchor.constraint(equalTo: artistSectionContainerView.bottomAnchor, constant: 5).isActive = true
        artistCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Search Functionality
    func searchAndDisplayArtists() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchySearch), object: nil)
        self.perform(#selector(searchySearch), with: nil, afterDelay: 0.5)
    }
    func searchySearch() {
        self.artistArray.removeAll()
        let group = DispatchGroup()
        group.enter()
        if (searchTextField.text != nil) && searchTextField.text != "" {
            DeezerManager.searchForArtist(artists: artistArray, searchString: searchTextField.text!) { (artists:[DeezerArtist]?, error:Error?) in
                
                if ((error) != nil) {
                    
                } else {
                    var deezerArtists = artists
                    for artist in self.filterArtistArray(artistArray: deezerArtists) {
                        self.artistArray.append(artist)
                    }
                    deezerArtists?.removeAll()
                }
                group.leave()
            }
            group.notify(queue: DispatchQueue.main) {
                
                self.artistCollectionView.reloadData()
            }
        } else {
            self.artistCollectionView.reloadData()
        }
    }
    func filterArtistArray(artistArray:[DeezerArtist]?) -> [DeezerArtist] {
        var containerArray = [DeezerArtist]()
        containerArray.removeAll()
        if let searchText = searchTextField.text, let artists = artistArray {
            let beginsWithPredicate = NSPredicate.init(format: "artistName beginsWith [cd] %@", searchText)
            let containsPredicate = NSPredicate.init(format: "not (artistName beginsWith [cd] %@)", searchText)
            let filteredArray = (artists as NSArray).filtered(using: beginsWithPredicate) as! [DeezerArtist]
            let containsArray = (artists as NSArray).filtered(using: containsPredicate) as! [DeezerArtist]
            
            containerArray = filteredArray + containsArray
        }
        return containerArray
    }
    func clearSearchTextField() {
        searchTextField.text = ""
    }
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Artist CollectionView
    lazy var artistCollectionView:UICollectionView = {
        let artistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        artistCollectionView.translatesAutoresizingMaskIntoConstraints = false
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
        artistCollectionView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        artistCollectionView.allowsSelection = true
        artistCollectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: "artistCollectionViewCell")
        return artistCollectionView
    }()
    //MARK: - Text Field
    private lazy var searchTextField:SearchTextField = {
        let searchTextField = SearchTextField()
        searchTextField.tintColor = .white
        searchTextField.textColor = .white
        searchTextField.addTarget(self, action: #selector(searchAndDisplayArtists), for: UIControlEvents.editingChanged)
        return searchTextField
    }()
    //MARK: - Container Views
    private lazy var artistImageContainerView:UIView = {
        let artistImageContainerView = UIView()
        artistImageContainerView.addSubview(self.artistSectionImageView)
        return artistImageContainerView
    }()
    private lazy var searchIconContainerView:UIView = {
        let searchIconContainerView = UIView()
        searchIconContainerView.addSubview(self.searchIconImageView)
        return searchIconContainerView
    }()
    private lazy var searchBarContainerView:UIView = {
        let searchBarContainerView = UIView()
        searchBarContainerView.addSubview(self.searchBarStackView)
        searchBarContainerView.backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
        return searchBarContainerView
    }()
    private lazy var artistSectionContainerView:UIView = {
        let artistSectionContainerView = UIView()
        artistSectionContainerView.addSubview(self.artistSectionStackView)
        artistSectionContainerView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        return artistSectionContainerView
    }()
    //MARK: - StackViews
    private lazy var searchBarStackView:UIStackView = {
        let searchBarStackView = UIStackView.init(arrangedSubviews: [self.moreButton, self.searchIconContainerView, self.searchTextField, self.clearButton])
        searchBarStackView.axis = .horizontal
        searchBarStackView.alignment = .fill
        searchBarStackView.distribution = .fillProportionally
        searchBarStackView.spacing = 15
        return searchBarStackView
    }()
    private lazy var artistSectionStackView:UIStackView = {
        let artistSectionStackView = UIStackView.init(arrangedSubviews: [self.artistImageContainerView, self.artistSectionLabel])
        artistSectionStackView.axis = .horizontal
        artistSectionStackView.alignment = .fill
        artistSectionStackView.distribution = .fillProportionally
        artistSectionStackView.spacing = 20
        return artistSectionStackView
    }()
}

//MARK: - Extensions - 
//MARK: - UICollectionView Delegate & DataSource
extension SearchArtistsViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var albumsArray = [DeezerAlbum]()
        let group = DispatchGroup()
        group.enter()
        DeezerManager.retrieveArtistAlbums(artist: artistArray[indexPath.item]) { (albums:[DeezerAlbum]?, error:Error?) in
            if let arrayOfAlbums = albums {
                albumsArray = arrayOfAlbums
            }
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) { 
            let albumsViewController = ArtistAlbumsViewController.init(albumsArray: albumsArray, albumArtistName: self.artistArray[indexPath.item].artistName)
            self.present(albumsViewController, animated: true, completion: nil)
        }
    }
}
extension SearchArtistsViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistArray.count // just for testing purposes right now
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //just testing right now
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCollectionViewCell", for: indexPath) as! ArtistCollectionViewCell
        cell.configureCell(artist: self.artistArray[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout Delegate
extension SearchArtistsViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 66)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}


