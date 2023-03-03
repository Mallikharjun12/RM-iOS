//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 01/03/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .light)
       // label.text = "Earth"
        return label
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.text = "Location"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let iconImageView:UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
      //  icon.image = UIImage(systemName: "globe.americas")
        return icon
    }()
    
    private let titleContainerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubviews(valueLabel,titleContainerView,iconImageView)
        titleContainerView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 8
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.33),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 35),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            
            valueLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor,constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
        iconImageView.image = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label
    }
    
    public func configure(with ViewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = ViewModel.title
        valueLabel.text = ViewModel.displayValue
        iconImageView.image = ViewModel.iconImage
        iconImageView.tintColor = ViewModel.tintColour
        titleLabel.textColor = ViewModel.tintColour
    }
}
