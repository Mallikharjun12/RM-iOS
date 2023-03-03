//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import UIKit

enum SectionType {
    case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
    case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
    case episodes(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
}

final class RMCharacterDetailViewViewModel {
    
    private let character:RMCharacter
    
    public var sections:[SectionType] = []
    
    //MARK: Init
    init(character:RMCharacter) {
        self.character = character
        setUpSections()
    }
    
    private func setUpSections() {
        
        /*
         let status: RMCharacterStatus
         let species: String
         let type: String
         let gender: RMCharacterGender
         let origin: RMOrigin
         let location: RMSingleLocation
         let image: String
         let episode: [String]
         let url: String
         let created: String
       
         */
        
        sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(
                viewModels: [
                    .init(type: .status  , value: character.status.text),
                    .init(type: .gender  , value: character.gender.rawValue),
                    .init(type: .type  , value: character.type),
                    .init(type: .species  , value: character.species),
                    .init(type: .origin  , value: character.origin.name),
                    .init(type: .location  , value: character.location.name),
                    .init(type: .created  , value: character.created),
                    .init(type: .episodeCount  , value: "\(character.episode.count)")
                ]),
            .episodes(viewModels: character.episode.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(epiosdeDataUrl: URL(string: $0))
            }))
        ]
    }
    
    private var requestUrl:URL? {
        return URL(string: character.url)
    }
    
    public var title:String {
        return character.name.uppercased()
    }
    
    //MARK: Compositional Layout
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection{
        let items = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [items])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(150)),
           subitems: [item,item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection{
        let items = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        items.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                      leading: 10,
                                                      bottom: 10,
                                                      trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .absolute(150)),
            subitems: [items])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
