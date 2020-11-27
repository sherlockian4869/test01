//
//  ThirdViewController.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/18.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var postNumber: Int?
    var ThirdUser: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postNumber = Int.random(in: 1 ... 6)
        print(postNumber)
    }
    
    @IBAction func PostBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "post", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "post" {
            let nextVC = segue.destination as! ForthViewController
            nextVC.receiveNumber = postNumber
            nextVC.ForthUser = ThirdUser
        }
    }
}
