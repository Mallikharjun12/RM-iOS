//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Mallikharjun kakarla on 26/02/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}


