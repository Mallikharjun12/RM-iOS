//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 01/03/23.
//

import UIKit


enum `Type` :String{
    case status
    case gender
    case type
    case species
    case origin
    case location
    case created
    case episodeCount
    
    
    var tintColor:UIColor {
        switch self {
            
        case .status:
            return .systemRed
        case .gender:
            return .systemYellow
        case .type:
            return .systemOrange
        case .species:
            return .systemBlue
        case .origin:
            return .systemPink
        case .location:
            return .systemGreen
        case .created:
            return .systemMint
        case .episodeCount:
            return .systemPurple
        }
    }
    
    var iconImage:UIImage? {
     switch self {
        case .status:
            return UIImage(systemName: "bell")
        case .gender:
            return UIImage(systemName: "bell")
        case .type:
            return UIImage(systemName: "bell")
        case .species:
            return UIImage(systemName: "bell")
        case .origin:
            return UIImage(systemName: "bell")
        case .location:
            return UIImage(systemName: "bell")
        case .created:
           return UIImage(systemName: "bell")
        case .episodeCount:
           return UIImage(systemName: "bell")
        }
    }
    
    var displayTitle:String {
        switch self {
            
        case .status:
            return rawValue.uppercased()
        case .gender:
            return rawValue.uppercased()
        case .type:
            return rawValue.uppercased()
        case .species:
            return rawValue.uppercased()
        case .origin:
            return rawValue.uppercased()
        case .location:
            return rawValue.uppercased()
        case .created:
            return rawValue.uppercased()
        case .episodeCount:
            return "EPISODE COUNT"
        }
    }
}

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let type:`Type`
    
    private let value:String
    
    public var title:String {
        return self.type.displayTitle
    }
    
    static let formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        return formatter
    }()
    
    static let shortFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
    
    public var displayValue:String {
        
        if let date = Self.formatter.date(from: value),type == .created {
            return Self.shortFormatter.string(from: date)
        }
        
        if value.isEmpty {return "some"}
        return value
    }
    
    public var iconImage:UIImage? {
        return type.iconImage
    }
    
    public var tintColour:UIColor {
        return type.tintColor
    }
    

    init(
        type: `Type`,
        value:String
    
    ) {
        self.type = type
        self.value = value
    }
}
