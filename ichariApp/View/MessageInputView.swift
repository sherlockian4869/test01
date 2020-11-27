//
//  MessageInputView.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/25.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseFirestore

protocol MessageInputViewDelegate: class {
    func TappeButton(message: String)
}

class MessageInputView: UIView {
    
    @IBOutlet weak var MessageTextView: UITextView!
    @IBOutlet weak var SendButton: UIButton!
    
    let db = Firestore.firestore()
    
    weak var delegate: MessageInputViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibInit()
        setUpViews()
        autoresizingMask = .flexibleHeight
    }
    
    private func setUpViews() {
        MessageTextView.layer.cornerRadius = 15
        MessageTextView.layer.borderColor = UIColor.rgb(red: 230, green: 230, blue: 230).cgColor
        MessageTextView.layer.borderWidth = 1
        
        SendButton.layer.cornerRadius = 15
        SendButton.contentHorizontalAlignment = .fill
        SendButton.contentVerticalAlignment = .fill
        SendButton.isEnabled = false
        
        MessageTextView.text = ""
        MessageTextView.delegate = self
    }
    
    func removeText() {
        MessageTextView.text = ""
        SendButton.isEnabled = false
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.MessageTextView.isFirstResponder) {
            self.MessageTextView.resignFirstResponder()
        }
    }
    
    @IBAction func TappeButton(_ sender: Any) {
        guard let message = MessageTextView.text else { return }
        delegate?.TappeButton(message: message)
    }
    
    private func nibInit() {
        let nib = UINib(nibName: "MessageInputView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageInputView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            SendButton.isEnabled = false
        } else {
            SendButton.isEnabled = true
        }
    }
}
