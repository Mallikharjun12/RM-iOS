//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import UIKit

/// Controller to show info about single character
class RMCharacterDetailViewController: UIViewController {

    private let viewModel:RMCharacterDetailViewViewModel
    init(viewModel:RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
}
