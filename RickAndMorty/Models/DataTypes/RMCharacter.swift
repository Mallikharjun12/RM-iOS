//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 25/02/23.
//

import Foundation

struct RMCharacter:Codable {
    
    
      let id: Int
      let name: String
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
    
}

enum RMCharacterStatus:String,Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text:String {
        switch self {
        case .alive:
            return rawValue
        case .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}

enum RMCharacterGender:String,Codable {
    //'Female', 'Male', 'Genderless' or 'unknown'
    
    case female  = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}




