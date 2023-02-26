//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 25/02/23.
//

import Foundation

struct RMGetAllCharactersResponse:Codable {
    let info:Info
    let results:[RMCharacter]
    
    struct Info:Codable {
        let count:Int
        let pages:Int
        let next:String?
        let prev:String?
    }
}


