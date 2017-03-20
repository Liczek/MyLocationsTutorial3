//
//  MyTabBarController.swift
//  MyLocationTutorial3
//
//  Created by Paweł Liczmański on 20.03.2017.
//  Copyright © 2017 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

class MyTabBarController: UITabBarController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return nil
    }
}
