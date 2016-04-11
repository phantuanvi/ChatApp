//
//  messageCell.swift
//  ChatApp
//
//  Created by Tuan-Vi Phan on 4/11/16.
//  Copyright © 2016 Tuan-Vi Phan. All rights reserved.
//

import UIKit

class messageCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    
    // MARK:
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
