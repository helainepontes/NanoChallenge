//
//  WaitViewController.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 10/02/21.
//  Copyright © 2021 Helaine Pontes. All rights reserved.
//

import UIKit
import Lottie

class WaitViewController: UIViewController {
    
    private var animationView: AnimationView?
    let tabBar = MainTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView = AnimationView(name: "recipes")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.animationSpeed = 1.0
        view.addSubview(animationView!)
        animationView?.backgroundColor = .backgroundYellow
        animationView?.play()
        animationView?.loopMode = .loop
        initTabBarController()
    }
    
    func initTabBarController() {
        let controller = tabBar.viewControllers?.first as! UINavigationController
        let categoryScreen = controller.topViewController as! CategoryViewController
        categoryScreen.waitView = self
        categoryScreen.viewDidLoad()
    }
    
    func presentCategoryScreen() {
        DispatchQueue.main.async { [self] in
            guard let window = UIApplication.shared.windows.first else { return }
                        window.rootViewController = tabBar
        }
    }

}
