//
//  ProdListTableViewCell.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import UIKit

class ProdListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var prodList_image: UIImageView!
    @IBOutlet weak var prodList_name: UILabel!
    @IBOutlet weak var prodList_producer: UILabel!
    @IBOutlet weak var prodList_price: UILabel!
    @IBOutlet weak var prodList_like: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
