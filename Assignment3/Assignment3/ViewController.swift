//
//  ViewController.swift
//  Assignment3
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //* Answer 6 BEGIN
    @IBOutlet weak var gridView: GridView!

    @IBAction func stepButtonPressed(_ sender: UIButton) {
        guard let grid = gridView  else{ return }
        grid.nextGrid()
        
    }
    //* Answer 6 END
    
    


}

