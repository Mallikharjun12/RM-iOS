//
//  RMCharacterListView.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import UIKit

protocol RMCharacterListViewDelegate:AnyObject {
    func rmCharacterListView(
        _ characterListView:RMCharacterListView ,
        didSelectcharacter character: RMCharacter
    )
}

/// View that handles showing list of characters,loader etc;
final class RMCharacterListView: UIView {
    
    public weak var delegate:RMCharacterListViewDelegate?
    
    private let viewModel = RMCharacterListViewViewModel()

    private let spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RmCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RmCharacterCollectionViewCell.identifier)
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        //backgroundColor = .systemBlue
        addSubviews(collectionView,spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo:topAnchor),
            collectionView.bottomAnchor.constraint(equalTo:bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo:leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:trailingAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
    
}

extension RMCharacterListView:RMCharacterListViewViewModelDelegate {
    func didLoadMoreCharacters(with indexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: indexPaths)
        }
    }
    
    func didSelect(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectcharacter: character)
    }
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        
        collectionView.reloadData() //Initial Fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
