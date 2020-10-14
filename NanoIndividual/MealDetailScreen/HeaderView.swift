//
//  HeaderView.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 20/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    let mealTitle = UILabel()
    let favoriteButton = UIButton()
    let saveFavorites = Persistence()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configMealTitle()
        configFavoriteButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if saveFavorites.existObjetc(object: mealTitle.text!) {
            let favoriteImage = UIImage(systemName: "star.fill")
            let blackFavoriteImage = favoriteImage?.withTintColor(.black, renderingMode: .alwaysOriginal)
            favoriteButton.setImage(blackFavoriteImage, for: .normal)
        } else {
            let favoriteImage = UIImage(systemName: "star")
            let blackFavoriteImage = favoriteImage?.withTintColor(.black, renderingMode: .alwaysOriginal)
            favoriteButton.setImage(blackFavoriteImage, for: .normal)
        }
    }
    
    func configMealTitle() {
        addSubview(mealTitle)
        mealTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        mealTitle.translatesAutoresizingMaskIntoConstraints = false
        mealTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mealTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    }
    
    func configFavoriteButton() {
        addSubview(favoriteButton)
        
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activateConstraints([favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),  favoriteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
        favoriteButton.addTarget(self, action: #selector(pressFavoriteButton), for: .touchUpInside)
        
    }
    
    @objc func pressFavoriteButton(sender: UIButton) {
        let favoriteImage = UIImage(systemName: "star.fill")
        let blackFavoriteImage = favoriteImage?.withTintColor(.black, renderingMode: .alwaysOriginal)
        favoriteButton.setImage(blackFavoriteImage, for: .normal)
        
        //User Defaults -> Guardar o prato favorito
        saveFavorites.add(object: mealTitle.text!)
    }
    
}
