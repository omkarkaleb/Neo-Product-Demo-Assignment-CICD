//
//  ProdListTableViewCell.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import UIKit
import CoreData

class ProdListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var prodList_image: UIImageView!
    @IBOutlet weak var prodList_name: UILabel!
    @IBOutlet weak var prodList_producer: UILabel!
    @IBOutlet weak var prodList_price: UILabel!
    @IBOutlet weak var prodList_like: UIButton!
    
    var product_id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //checkLike(id: Int16(product_id))
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        if prodList_like.isSelected == true {
            prodList_like.isSelected = false
            Like_Checker_Instance.deleteItem(id: Int16(product_id))
        }else{
            prodList_like.isSelected = true
            Like_Checker_Instance.createItem(id: Int16(product_id))
        }
    }
}
