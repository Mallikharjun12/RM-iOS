//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 10/03/23.
//

import UIKit

/// VC to show details about a single episode
final class RMEpisodeDetailViewController: UIViewController {

   private var url:URL?
    
    //MARK: init
    init(url:URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Epiosde"
        view.backgroundColor = .systemRed
    }
    

    

}
