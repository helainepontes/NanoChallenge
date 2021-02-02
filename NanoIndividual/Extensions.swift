//
//  Cores.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 18/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let backgroundGray = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.00)
    static let backgroundYellow = UIColor(red: 0.94, green: 0.87, blue: 0.69, alpha: 1.00)
    static let coralOrange = UIColor(red: 1.00, green: 0.54, blue: 0.44, alpha: 1.00)
}

extension UIImage {

    convenience init?(withContentsOfUrl name: String) throws {
        guard let resourceURL = URL(string: name) else {fatalError() }
        let imageData = try Data(contentsOf: resourceURL)
        self.init(data: imageData)
    }

}

class FirstBackgroundGradient {

    var gradientLayer: CAGradientLayer

   init() {
    let colorTop = UIColor(red: 0.14, green: 0.14, blue: 0.14, alpha: 0.7).cgColor
    let colorBottom = UIColor(red: 0.62, green: 0.62, blue: 0.62, alpha: 0).cgColor

    self.gradientLayer = CAGradientLayer()
    self.gradientLayer.colors = [colorTop, colorBottom]
    self.gradientLayer.locations = [0.0, 1.0]
   }
}
