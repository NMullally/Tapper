//
//  PlayerInfoCell.swift
//  Tapper
//
//  Created by Niall Mullally on 06/11/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import UIKit

class PlayerInfoCell: UITableViewCell
{
    @IBOutlet weak var mHighScore: UILabel!
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mPosition: UILabel!
    @IBOutlet weak var mName: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
