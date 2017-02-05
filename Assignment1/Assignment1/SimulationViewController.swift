//
//  SimulationViewController.swift
//  Assignment1
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func overrideTraitCollection(forChildViewController childViewController: UIViewController) -> UITraitCollection? {
        
        print("begin: nothing to override");
        
        if UI_USER_INTERFACE_IDIOM() == .pad &&
            view.bounds.width > view.bounds.height {
            
            let collections = [UITraitCollection(horizontalSizeClass: .regular),
                               UITraitCollection(verticalSizeClass: .compact)]
            
            print("Swpping Size Class");
            
            return UITraitCollection(traitsFrom: collections)
            
        }
        
         print("end: nothing to override");
        
        return super.overrideTraitCollection(forChildViewController: childViewController)
    }


}



