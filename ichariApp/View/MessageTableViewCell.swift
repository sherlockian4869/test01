//
//  MessageTableViewCell.swift
//  ichariApp
//
//  Created by Kohei Yaeo on 2020/11/25.
//  Copyright © 2020 sherlockian. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var UserLabel: UILabel!
    @IBOutlet weak var MessageTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
