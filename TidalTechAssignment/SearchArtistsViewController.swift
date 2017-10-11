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
    
    let searchBarContainerView = UIView()
    
    let artistSectionContainerView = UIView()
    let artistSectionImageView = UIImageView()
    let artistSectionLabel = UILabel()
    
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
        artistSectionContainerView.addSubview(artistSectionStackView)
        searchBarContainerView.addSubview(searchBarStackView)
        searchBarContainerView.backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
        artistSectionContainerView.backgroundColor = UIColor.init(colorLiteralRed: (35/251), green: (35/251), blue: (35/251), alpha: 1)
        view.addSubview(searchBarContainerView)
        view.addSubview(artistSectionContainerView)
        view.addSubview(artistCollectionView)
        view.backgroundColor = .black
        
        //constraints
        searchBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchBarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarContainerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        searchBarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarContainerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        artistSectionContainerView.translatesAutoresizingMaskIntoConstraints = false
        artistSectionContainerView.topAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        artistSectionContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        artistSectionContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        artistSectionContainerView.heightAnchor.constraint(equalTo: searchBarContainerView.heightAnchor).isActive = true
        
        
        artistSectionStackView.translatesAutoresizingMaskIntoConstraints = false
        artistSectionStackView.leadingAnchor.constraint(equalTo: artistSectionContainerView.leadingAnchor).isActive = true
        artistSectionStackView.topAnchor.constraint(equalTo: artistSectionContainerView.topAnchor).isActive = true
        artistSectionStackView.trailingAnchor.constraint(equalTo: artistSectionContainerView.trailingAnchor).isActive = true
        artistSectionStackView.bottomAnchor.constraint(equalTo: artistSectionContainerView.bottomAnchor).isActive = true
        
        artistSectionImageView.translatesAutoresizingMaskIntoConstraints = false
        artistSectionImageView.contentMode = .center
        artistSectionImageView.widthAnchor.constraint(equalTo: artistSectionImageView.heightAnchor).isActive = true
        
        if let artistSectionImage = UIImage.init(named: "microphone") {
            artistSectionImageView.image = artistSectionImage
        }
        
        artistSectionLabel.text = "ARTIST"
        artistSectionLabel.textColor = .white

        if let moreButtonImageView = moreButton.imageView {
            moreButtonImageView.translatesAutoresizingMaskIntoConstraints = false
            moreButtonImageView.widthAnchor.constraint(equalTo: moreButtonImageView.heightAnchor).isActive = true
            moreButtonImageView.contentMode = .center
            
        }
        moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor).isActive = true
        searchBarStackView.translatesAutoresizingMaskIntoConstraints = false
        searchBarStackView.topAnchor.constraint(equalTo: searchBarContainerView.topAnchor, constant: 8).isActive = true
        searchBarStackView.leadingAnchor.constraint(equalTo: searchBarContainerView.leadingAnchor, constant: 8).isActive = true
        searchBarStackView.trailingAnchor.constraint(equalTo: searchBarContainerView.trailingAnchor, constant: -8).isActive = true
        searchBarStackView.bottomAnchor.constraint(equalTo: searchBarContainerView.bottomAnchor).isActive = true
        
        artistCollectionView.topAnchor.constraint(equalTo: artistSectionContainerView.bottomAnchor, constant: 5).isActive = true
        artistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        artistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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
    //MARK: - Buttons
    private lazy var moreButton:UIButton = {
        let moreButton = UIButton(type: UIButtonType.custom)
        moreButton.setImage(UIImage.init(named: "moreMenuIcon"), for: .normal)
        return moreButton
    }()
    //MARK: - Text Field
    private lazy var searchTextField:UITextField = {
        let searchTextField = UITextField()
        searchTextField.backgroundColor = .white
        searchTextField.addTarget(self, action: #selector(searchAndDisplayArtists), for: UIControlEvents.editingChanged)
        return searchTextField
    }()
    //MARK: - StackViews
    private lazy var searchBarStackView:UIStackView = {
        let searchBarStackView = UIStackView.init(arrangedSubviews: [self.moreButton, self.searchTextField])
        searchBarStackView.axis = .horizontal
        searchBarStackView.alignment = .fill
        searchBarStackView.distribution = .fillProportionally
        searchBarStackView.spacing = 5
        return searchBarStackView
    }()
    private lazy var artistSectionStackView:UIStackView = {
        let artistSectionStackView = UIStackView.init(arrangedSubviews: [self.artistSectionImageView, self.artistSectionLabel])
        artistSectionStackView.axis = .horizontal
        artistSectionStackView.alignment = .fill
        artistSectionStackView.distribution = .fillProportionally
        artistSectionStackView.spacing = 5
        return artistSectionStackView
    }()
}

//MARK: - Extensions - 
//MARK: - UICollectionView Delegate & DataSource
extension SearchArtistsViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumsViewController = ArtistAlbumsViewController()
        present(albumsViewController, animated: true, completion: nil)
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


