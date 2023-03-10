//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 25/02/23.
//

import UIKit

/// Controller to show and search for Characters
final class RMCharacterViewController: UIViewController {

    private let characterListView = RMCharacterListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
    }
    

    private func setUpView() {
        view.addSubview(characterListView)
        characterListView.delegate = self
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

//MARK: RMCharacterListViewDelegate implementation

extension RMCharacterViewController: RMCharacterListViewDelegate{
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectcharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let vc = RMCharacterDetailViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
