//
//  SecondViewController.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/18.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class SecondViewController: UIViewController {

    var SecondUser: String?
    
    let db = Firestore.firestore()
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.noButton(registerButton)
        NameTextField.delegate = self
        registerButton.isEnabled = false
    }
    
    @IBAction func NameRegisterBtn(_ sender: Any) {
        SecondUser = NameTextField.text
        db.collection("UserName").addDocument(data: [
            "Name" : NameTextField.text!
        ])
    }
    
    // キーボード下げる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func NextView(_ sender: Any) {
        self.performSegue(withIdentifier: "NextThird", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextThird" {
            let nextVC = segue.destination as! ThirdViewController
            nextVC.ThirdUser = SecondUser
        }
    }
}

extension SecondViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let NameIsEmpty = NameTextField.text?.isEmpty ?? false
        
        if NameIsEmpty {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .rgb(red: 224, green: 224, blue: 224)
        } else {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .white
        }
    }
}
