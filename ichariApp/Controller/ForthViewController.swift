//
//  ForthViewController.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/18.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ForthViewController: UIViewController {

    @IBOutlet weak var FortuneLabel: UILabel!
    @IBOutlet weak var CommentLabel: UILabel!
    @IBOutlet weak var TalkLabel: UILabel!
    
    var receiveNumber : Int?
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(receiveNumber)
        
        db.collection("result").whereField("ID", isEqualTo: self.receiveNumber!).getDocuments { (snaps, error) in
            if error != nil {
                
            } else {
                guard let snaps = snaps else {
                    return
                }
                for document in snaps.documents {
                    let Object = document.data() as [String: AnyObject]
                    let comment = Object["comment"]
                    let fortune = Object["fortune"]
                    let talk = Object["talk"]
                    
                    self.FortuneLabel.text = fortune as? String
                    self.CommentLabel.text = comment as? String
                    self.TalkLabel.text = talk as? String
                }
            }
        }
    }
    
    @IBAction func roomBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "postRoom", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postRoom" {
            let nextVC = segue.destination as! ChatViewController
            nextVC.roomNumber = receiveNumber
        }
    }
}
