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
import PKHUD

class FifthViewController: UIViewController {
    
    private let cellId = "cellId"
    
    @IBOutlet weak var MessageTableView: UITableView!
    var FifthUser: String = ""
    var FifthNumber: Int?
    let db = Firestore.firestore()
    private var messageList = [MessageModel]()
    
    private let tableViewContentInset: UIEdgeInsets = .init(top: 60, left: 0, bottom: 0, right: 0)
    private let tableViewIndicatorInset: UIEdgeInsets = .init(top: 60, left: 0, bottom: 0, right: 0)
    private let accessoryHeight: CGFloat = 100
    private var safeAreaBottom: CGFloat {
        self.view.safeAreaInsets.bottom
    }
    
    private lazy var messageInputView: MessageInputView = {
        let view = MessageInputView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: accessoryHeight)
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
        
        setupNotification()
        MessageTableView.delegate = self
        MessageTableView.dataSource = self
        MessageTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        MessageTableView.contentInset = tableViewContentInset
        MessageTableView.scrollIndicatorInsets = tableViewIndicatorInset
        MessageTableView.keyboardDismissMode = .interactive
        MessageTableView.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        guard let userInfo = notification.userInfo else { return }
        
        if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            
            if keyboardFrame.height <= accessoryHeight { return }
            print("keyboardFrame:", keyboardFrame)
            
            let top = keyboardFrame.height - safeAreaBottom
            var moveY = -(top - MessageTableView.contentOffset.y)
            if MessageTableView.contentOffset.y == -60 { moveY += 60 }
            print("chatRoomTableView.contentOffset.y:", MessageTableView.contentOffset.y)
            let contentInset = UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
            
            MessageTableView.contentInset = contentInset
            MessageTableView.scrollIndicatorInsets = contentInset
            MessageTableView.contentOffset = CGPoint(x: 0, y: moveY)
        }
    }
    
    @objc func keyboardWillHide() {
        print("keyboardWillHide")
        MessageTableView.contentInset = tableViewContentInset
        MessageTableView.scrollIndicatorInsets = tableViewIndicatorInset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMessage()
    }
    
    private func fetchMessage() {
        HUD.show(.progress)
        
        db.collection("MessageRoom").order(by: "CreateAt", descending: false).getDocuments { (snaps, error) in
            if error != nil {
                HUD.hide()
            } else {
                guard let snaps = snaps else { return }
                HUD.hide()
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
    
}

extension FifthViewController: MessageInputViewDelegate {
    func TappeButton(message: String) {
        let db = Firestore.firestore()
        let Messages = MessageModel(User: FifthUser, Message: message)
        messageList.append(Messages)
        messageInputView.removeText()
        messageInputView.MessageTextView.text = ""
        db.collection("MessageRoom").addDocument(data: [
            "User" : FifthUser,
            "Message" : message,
            "CreateAt" : Timestamp()
        ])

        MessageTableView.reloadData()
    }
}

extension FifthViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        MessageTableView.estimatedRowHeight = 20
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MessageTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageTableViewCell
        cell.user = messageList[indexPath.row]
        cell.message = messageList[indexPath.row]
        cell.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        return cell
    }
}
