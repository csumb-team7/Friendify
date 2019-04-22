//
//  SongCell.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 4/17/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImage.layer.borderWidth = 1
        userImage.layer.masksToBounds = false
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
        
        songImage.layer.borderWidth = 1
        songImage.layer.masksToBounds = false
        songImage.layer.cornerRadius = songImage.frame.height/2
        songImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
