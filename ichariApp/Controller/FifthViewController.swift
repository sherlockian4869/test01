//
//  FifthViewController.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/25.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FifthViewController: UIViewController {
    
    private var messages = [String]()
    
    @IBOutlet weak var MessageTableView: UITableView!
    var FifthUser: String?
    let db = Firestore.firestore()
    var messageList = [MessageModel]()
    
    private lazy var messageInputView: MessageInputView = {
        let view = MessageInputView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        view.delegate = self
        return view
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return messageInputView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        db.collection("MessageRoom").getDocuments{ (snaps, error) in
            if error != nil {
                
            } else {
                guard let snaps = snaps else {
                    return
                }
                
                for document in snaps.documents {
                    let messageObject = document.data() as [String: AnyObject]
                    let User = messageObject["User"]
                    let Message = messageObject["Message"]
                        
                    let Messages = MessageModel(User: User as? String, Message: Message as? String)
                    self.messageList.append(Messages)
                }
            }
            self.MessageTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension FifthViewController: MessageInputViewDelegate {
    func TappeButton(message: String) {
        let db = Firestore.firestore()
        let Messages = MessageModel(User: FifthUser, Message: message)
        messageList.append(Messages)
        messageInputView.removeText()
        messageInputView.MessageTextView.text = ""
        db.collection("MessageRoom").addDocument(data: [
            "User" : FifthUser!,
            "Message" : message
        ])
        MessageTableView.reloadData()
    }
}

extension FifthViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageTableViewCell
        
        let Message: MessageModel
        Message = messageList[indexPath.row]
        
        return cell
    }
}
