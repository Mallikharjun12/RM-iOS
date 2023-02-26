//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character:RMCharacter
    
    init(character:RMCharacter) {
        self.character = character
    }
    
    public var title:String {
        return character.name.uppercased()
    }
}
