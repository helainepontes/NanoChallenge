//
//  EmptyState.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 05/02/21.
//  Copyright © 2021 Helaine Pontes. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func emptyState(textTitle: String, textDescription: String, image: String) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let textTitle: UILabel = {
            let label = UILabel()
            label.text = textTitle
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let textDescription: UILabel = {
            let label = UILabel()
            label.text = textDescription
            label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            label.adjustsFontSizeToFitWidth = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let emptyImage: UIImageView = {
            let picture = UIImageView()
            picture.image = UIImage(named: image)
            picture.translatesAutoresizingMaskIntoConstraints = false
            return picture
        }()
        
        emptyView.addSubview(textTitle)
        emptyView.addSubview(textDescription)
        emptyView.addSubview(emptyImage)
        
        //constraintImage
        NSLayoutConstraint.activate([
            emptyImage.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 16),
            emptyImage.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            emptyImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4)
        ])
        emptyImage.layer.cornerRadius = (UIScreen.main.bounds.width * 0.4)/2
        emptyImage.clipsToBounds = true
        
        //constraintTitle
        NSLayoutConstraint.activate([
            textTitle.topAnchor.constraint(equalTo: emptyImage.bottomAnchor, constant: 16),
            textTitle.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])

        //constraintDescription
        NSLayoutConstraint.activate([
            textDescription.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 8),
            textDescription.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor)
        ])
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
    }
}
