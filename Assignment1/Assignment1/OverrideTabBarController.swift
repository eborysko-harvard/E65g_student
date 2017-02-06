//
//  OverideTabBarController.swift
//  Assignment1
//
//  Created by Evan Borysko on 2/5/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class OverrideTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func overrideTraitCollection(
        forChildViewController childViewController: UIViewController) -> UITraitCollection? {

        // When device is iPad and is in landscape orientation
        if UI_USER_INTERFACE_IDIOM() == .pad &&
            view.bounds.width > view.bounds.height {
            
            // print("Create alternate traits / size class for iPad w:R h:C");
            let collections = [ UITraitCollection(horizontalSizeClass: .regular),
                                UITraitCollection(verticalSizeClass: .compact) ]
            
            return UITraitCollection(traitsFrom: collections)
            
        }

        // Otherwise returnt the standard traits
        return super.overrideTraitCollection(forChildViewController: childViewController)
    }
    

}
