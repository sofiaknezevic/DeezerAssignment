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
    
    private let artistSectionImageView = UIImageView()
    private let artistSectionLabel = UILabel()
    
    private let searchIconImageView = UIImageView()

    private let clearButton = UIButton()
    private let moreButton = UIButton()
    
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
    private func setSubviewImages() {
        artistSectionImageView.image = UIImage.init(named: StringConstants.microphoneImageName)
        searchIconImageView.image = UIImage.init(named: StringConstants.searchIconImageName)
        clearButton.setImage(UIImage.init(named: StringConstants.clearIconImageName), for: .normal)
        moreButton.setImage(UIImage.init(named: StringConstants.moreMenuIconImageName), for: .normal)
    }
    private func setSubviewProperties() {
        artistSectionLabel.text = StringConstants.artistSectionText
        artistSectionLabel.textColor = .white
        
        clearButton.addTarget(self, action: #selector(clearSearchTextField), for: .touchUpInside)
    }
    private func setConstraints() {
        //icon image view
        searchIconImageView.constrainIconImageView(imageView: searchIconImageView, to: searchIconContainerView)
        
        //searchbarcontainerview
        Utilities.constrainLeadingAndTrailing(childView: searchBarContainerView, parentView: view, constant: 0)
        searchBarContainerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        searchBarContainerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: SizeConstants.barHeightMultipler).isActive = true
        
        //artistsectioncontainerview
        Utilities.constrainLeadingAndTrailing(childView: artistSectionContainerView, parentView: view, constant: 0)
        artistSectionContainerView.topAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        artistSectionContainerView.heightAnchor.constraint(equalTo: searchBarContainerView.heightAnchor).isActive = true
        
        //artistsectionimageview
        artistSectionImageView.constrainIconImageView(imageView: artistSectionImageView, to: artistImageContainerView)
        
        //artistsectionstackview
        Utilities.constrainLeadingAndTrailing(childView: artistSectionStackView, parentView: artistSectionContainerView, constant: 10)
        artistSectionStackView.topAnchor.constraint(equalTo: artistSectionContainerView.topAnchor).isActive = true
        artistSectionStackView.bottomAnchor.constraint(equalTo: artistSectionContainerView.bottomAnchor).isActive = true
        
        //buttons
        moreButton.constrainIconButton(iconButton: moreButton)
        clearButton.constrainIconButton(iconButton: clearButton)
        
        //searchbarstackview
        Utilities.constrainLeadingAndTrailing(childView: searchBarStackView, parentView: searchBarContainerView, constant: SizeConstants.marginPadding)
        searchBarStackView.topAnchor.constraint(equalTo: searchBarContainerView.topAnchor, constant: SizeConstants.marginPadding).isActive = true
        searchBarStackView.bottomAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        
        //artistcollectionview
        Utilities.constrainLeadingAndTrailing(childView: artistCollectionView, parentView: view, constant: 0)
        artistCollectionView.topAnchor.constraint(equalTo: artistSectionContainerView.bottomAnchor, constant: 2).isActive = true
        artistCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Search Functionality
    func searchAfterDelay() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchAndDisplayArtists), object: nil)
        self.perform(#selector(searchAndDisplayArtists), with: nil, afterDelay: 0.5)
    }
    func searchAndDisplayArtists() {
        artistArray.removeAll()
        
        let searchForArtistGroup = DispatchGroup()
        searchForArtistGroup.enter()
        
        if (searchTextField.text != nil) && searchTextField.text != "" {
            DeezerManager.searchForArtist(artists: artistArray, searchString: searchTextField.text!) { (artists:[DeezerArtist]?, error:Error?) in
                if ((error) != nil) {
                    SVProgressHUD.showError(withStatus: StringConstants.fetchRequestErrorTitle)
                } else {
                    var deezerArtists = artists
                    for artist in self.filterArtistArray(artistArray: deezerArtists) {
                        self.artistArray.append(artist)
                    }
                    deezerArtists?.removeAll()
                }
                searchForArtistGroup.leave()
            }
            searchForArtistGroup.notify(queue: DispatchQueue.main) {
                self.artistCollectionView.reloadData()
            }
        } else {
            self.artistCollectionView.reloadData()
        }
    }
    private func filterArtistArray(artistArray:[DeezerArtist]?) -> [DeezerArtist] {
        var containerArray = [DeezerArtist]()
        containerArray.removeAll()
        
        if let searchText = searchTextField.text, let artists = artistArray {
            
            let beginsWithPredicate = NSPredicate.init(format: "artistName beginsWith [cd] %@", searchText)
            let notBeginsWithPredicate = NSPredicate.init(format: "not (artistName beginsWith [cd] %@)", searchText)
            
            let beginsWithArray = (artists as NSArray).filtered(using: beginsWithPredicate) as! [DeezerArtist]
            let notBeginsWithArray = (artists as NSArray).filtered(using: notBeginsWithPredicate) as! [DeezerArtist]
            
            containerArray = beginsWithArray + notBeginsWithArray
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
        
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
        
        artistCollectionView.backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
        artistCollectionView.allowsSelection = true
        
        artistCollectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: StringConstants.artistCellIdentifier)
        return artistCollectionView
    }()
    //MARK: - Text Field
    private lazy var searchTextField:SearchTextField = {
        let searchTextField = SearchTextField()
        searchTextField.tintColor = .white
        searchTextField.textColor = .white
        searchTextField.addTarget(self, action: #selector(searchAfterDelay), for: UIControlEvents.editingChanged)
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
        
        let retrieveAlbumsGroup = DispatchGroup()
        retrieveAlbumsGroup.enter()
        
        DeezerManager.retrieveArtistAlbums(artist: artistArray[indexPath.item]) { (albums:[DeezerAlbum]?, error:Error?) in
            if ((error) != nil) {
                SVProgressHUD.showError(withStatus: StringConstants.fetchRequestErrorTitle)
            } else {
                if let arrayOfAlbums = albums {
                    albumsArray = arrayOfAlbums
                }
            }
            retrieveAlbumsGroup.leave()
        }
        
        retrieveAlbumsGroup.notify(queue: DispatchQueue.main) {
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
        return self.artistArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringConstants.artistCellIdentifier, for: indexPath) as! ArtistCollectionViewCell
        cell.configureCell(artist: self.artistArray[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewFlowLayout Delegate
extension SearchArtistsViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: SizeConstants.artistCellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


