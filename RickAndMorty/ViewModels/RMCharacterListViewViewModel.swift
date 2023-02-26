//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import UIKit

protocol RMCharacterListViewViewModelDelegate:AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with indexPaths:[IndexPath])
    func didSelect(_ character: RMCharacter)
}

/// ViewModel to handle character list view logic
final class RMCharacterListViewViewModel:NSObject {
    
    public weak var delegate:RMCharacterListViewViewModelDelegate?
    
    private var isLoadingMoreCharacters:Bool = false
    
    private var characters:[RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RmCharacterCollectionViewCellViewModel(characterName: character.name,
                                                                       characterStatus: character.status,
                                                                       characterImageUrl: URL(string: character.image))
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels:[RmCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo:RMGetAllCharactersResponse.Info? = nil
    
    /// fetch initial set of characters(20)
    public func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) {[weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// paginate if additional characters are needed
    public func fetchAdditionalCharacters(url:URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        //print("Fetching more characters")
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacters = false
            print("Failed to create request")
            return
        }
        RMService.shared.execute(request, expecting: RMGetAllCharactersResponse.self) {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
              //  print("Pre-update:\(strongSelf.characters.count)")
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathsToAdd:[IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
               // print(indexPathsToAdd)
                strongSelf.characters.append(contentsOf: moreResults)
               // print(strongSelf.characters.count)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd )
                    strongSelf.isLoadingMoreCharacters = false
                }
              //  print("post-update:\(strongSelf.characters.count)")
            case .failure(let error):
                strongSelf.isLoadingMoreCharacters = false
                print(String(describing: error))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator:Bool {
        return apiInfo?.next != nil
    }
}
//MARK: CollectionView implementation
extension RMCharacterListViewViewModel:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RmCharacterCollectionViewCell.identifier, for: indexPath) as! RmCharacterCollectionViewCell
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,shouldShowLoadMoreIndicator else {
            fatalError("Unsupported")
        }
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? RMFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]

        delegate?.didSelect(character)
    }
}
//MARK: ScrollView
extension RMCharacterListViewViewModel:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(url: url)
                
            }
            t.invalidate()
        }
    
//        print("Offset:\(offset)")
//        print("totalContentHeight:\(totalContentHeight)")
//        print("totalScrollViewFixedHeight:\(totalScrollViewFixedHeight)")
        
        
    }
}
