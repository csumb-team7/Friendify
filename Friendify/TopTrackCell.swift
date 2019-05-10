//
//  TopTrackCell.swift
//  Friendify
//
//  Created by Alexis Gonzalez on 5/10/19.
//  Copyright © 2019 alexis. All rights reserved.
//

import UIKit

class TopTrackCell: UITableViewCell {

    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
