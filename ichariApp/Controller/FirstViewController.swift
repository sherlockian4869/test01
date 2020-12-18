//
//  ViewController.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/18.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleHollowButton(startButton)
    }

}

