//
//  CategoryCollectionViewCell.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 18/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    static let xibName = "Category"
    static let identifier = "categoryCell"
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //categoryImage.roundCorners(corners: [.topRight, .topLeft], radius: 6)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configTitle()
        categoryView.backgroundColor = .backgroundGray
        self.categoryView.layer.masksToBounds = true
        categoryView.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = .init(width: 1, height: 3)
        
    }
    func configTitle() {
        categoryTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        categoryTitle.textColor = .black
    }
}
