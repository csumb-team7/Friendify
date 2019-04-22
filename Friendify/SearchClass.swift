//
//  SearchClass.swift
//  Friendify
//
//  Created by Mayra Ochoa on 4/22/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit

class SearchClass: UITableViewCell {

    @IBOutlet weak var userConnectionsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Initialization code
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
