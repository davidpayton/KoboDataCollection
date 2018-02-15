//
//  QuestionTableViewCell.swift
//  Kobo
//
//  Created by KobeBryant on 12/7/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {


    @IBOutlet weak var tvcellQuestion: UILabel!
    
    @IBOutlet weak var tvcellAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
