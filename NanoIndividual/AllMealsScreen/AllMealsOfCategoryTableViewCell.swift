//
//  AllMealsOfCategoryTableViewCell.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 19/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class AllMealsOfCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealTitle: UILabel!
    @IBOutlet weak var mealView: UIView!
    @IBOutlet weak var mealContentView: UIView!
    
    static let identifier = "identifier"
    static let xibName = "AllMeals"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configText()
        configView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configText() {
        mealTitle.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    func configView() {
        mealView.backgroundColor = .backgroundGray
        mealContentView.backgroundColor = .backgroundYellow
        self.mealView.layer.masksToBounds = true
        mealView.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.16
        self.layer.shadowOffset = .init(width: 60, height: 200)
    }
}
