//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 25/02/23.
//

import Foundation
/// Represents unique api endpoint
@frozen enum RMEndpoint:String {
    ///Endpoint to get character info
    case character //character
    ///Endpoint to get location info
    case location
    ///Endpoint to get episode info
    case episode
}
