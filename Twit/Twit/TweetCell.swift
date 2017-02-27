//
//  TweetCell.swift
//  Twit
//
//  Created by YangSzu Kai on 2017/2/26.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var ProfielPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
