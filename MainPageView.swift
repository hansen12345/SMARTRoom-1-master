//
//  MainPageView.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 1/18/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import Foundation
import UIKit

class MainPageView: UIViewController {
    
    @IBOutlet var RoomPage: UIView!
    @IBOutlet var DataPage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
                self.RoomPage.alpha = 1
                self.DataPage.alpha = 0
        
        } else {
            self.RoomPage.alpha = 0
            self.DataPage.alpha = 1
        }
    }
}

