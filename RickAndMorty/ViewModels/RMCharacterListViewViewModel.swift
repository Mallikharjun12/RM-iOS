//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import Foundation
import UIKit

protocol RMCharacterListViewViewModelDelegate:AnyObject {
    func didLoadInitialCharacters()
}

final class RMCharacterListViewViewModel:NSObject {
    
    public weak var delegate:RMCharacterListViewViewModelDelegate?
    private var characters:[RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RmCharacterCollectionViewCellViewModel(characterName: character.name,
                                                                       characterStatus: character.status,
                                                                       characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels:[RmCharacterCollectionViewCellViewModel] = []
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) {[weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension RMCharacterListViewViewModel:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RmCharacterCollectionViewCell.identifier, for: indexPath) as! RmCharacterCollectionViewCell
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
}
