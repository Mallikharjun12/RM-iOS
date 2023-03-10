//
//  RMCharacterEpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 01/03/23.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterEpisodeCollectionViewCell"
    
    private let seasonLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let airDateLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemBlue.cgColor
        contentView.addSubviews(seasonLabel,nameLabel,airDateLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
           nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
           nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
           nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
           nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    public func configure(with ViewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        ViewModel.registerForData { [weak self]data in
            
            print(data.episode)
            print(data.name)
            print(data.air_date)
            
            self?.airDateLabel.text = "Aired on "+data.air_date
            self?.airDateLabel.textColor = .systemRed
            self?.nameLabel.text = data.name
            self?.nameLabel.textColor = .systemBlue
            self?.seasonLabel.text = "Episode "+data.episode
            self?.seasonLabel.textColor = .systemPink
        }
        ViewModel.fetchEpisode()
    }
}
