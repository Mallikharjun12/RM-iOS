//
//  RmCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import Foundation

final class RmCharacterCollectionViewCellViewModel:Hashable,Equatable {
    
    
    public let characterName:String
    private let characterStatus:RMCharacterStatus
    private let characterImageUrl:URL?
    
    
    //MARK: Init
    init(characterName:String,
         characterStatus:RMCharacterStatus,
         characterImageUrl:URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText:String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion:@escaping(Result<Data,Error>)->Void) {
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url: url, completion: completion)
    }
    
    //MARK: Hash
    static func == (lhs: RmCharacterCollectionViewCellViewModel, rhs: RmCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }


    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}
