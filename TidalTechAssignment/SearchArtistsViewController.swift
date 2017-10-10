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

    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        
        let group = DispatchGroup()
        group.enter()
        DeezerManager.searchForArtist(artists: artistArray, searchString: "e") { (artists:[DeezerArtist]?, error:Error?) in
            
            if ((error) != nil) {
                
            } else {
                for artist in artists! {
                    self.artistArray.append(artist)
                }
            }
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) { 
            self.setUpView()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup & Configuration
    private func setUpView() {
        view.addSubview(searchBarStackView)
        view.addSubview(artistCollectionView)
        view.backgroundColor = UIColor.init(colorLiteralRed: (28/251), green: (28/251), blue: (28/251), alpha: 1)
        
        //constraints
        

        if let moreButtonImageView = moreButton.imageView {
            moreButtonImageView.translatesAutoresizingMaskIntoConstraints = false
            moreButtonImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
            moreButtonImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        }
        moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor).isActive = true
        searchBarStackView.translatesAutoresizingMaskIntoConstraints = false
        searchBarStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8).isActive = true
        searchBarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        searchBarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        searchBarStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
        artistCollectionView.topAnchor.constraint(equalTo: searchBarStackView.bottomAnchor).isActive = true
        artistCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        artistCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        artistCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Search Functionality
    
    //MARK: - Lazy Initializer Variables
    //MARK: - Artist CollectionView
    lazy var artistCollectionView:UICollectionView = {
        let artistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        artistCollectionView.translatesAutoresizingMaskIntoConstraints = false
        artistCollectionView.delegate = self
        artistCollectionView.dataSource = self
        artistCollectionView.backgroundColor = .clear
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
}

//MARK: - Extensions - 
//MARK: - UICollectionView Delegate & DataSource
extension SearchArtistsViewController:UICollectionViewDelegate {
    
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
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
}

//MARK: - TextField Delegate
//extension SearchArtistsViewController:UITextFieldDelegate {
//    
//}

