//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 01/03/23.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    
    private var imageUrl:URL?
    
    init(imageUrl:URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data,Error>)->Void) {
        
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downloadImage(url: imageUrl, completion: completion)
    }
}
