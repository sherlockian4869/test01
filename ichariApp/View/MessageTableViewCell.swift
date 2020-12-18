//
//  MessageTableViewCell.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/25.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var message: MessageModel? {
        didSet {
            if let message = message {
                messageTextView.text = message.Message
                let witdh = estimateFrameForTextView(text: message.Message!).width + 20
                messageTextViewWidthConstraint.constant = witdh
            }
        }
    }
    
    var user: MessageModel? {
        didSet {
            if let user = user {
                usernameLabel.text = user.User
            }
        }
    }

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    @IBOutlet weak var messageTextViewWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        usernameLabel.backgroundColor = .clear
        messageTextView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func estimateFrameForTextView(text: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], context: nil)
    }

}
