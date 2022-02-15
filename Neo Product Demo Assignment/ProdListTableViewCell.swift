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
    var Like_Checker_Service: LikeChecker? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        //checkLike(id: Int16(product_id))
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        guard let LCS = Like_Checker_Service else { return }
        if prodList_like.isSelected == true {
            prodList_like.isSelected = false
            do {
                try LCS.deleteItem(id: Int16(product_id))
            } catch {
                //ERROR
            }
        }else{
            prodList_like.isSelected = true
            do {
                try LCS.createItem(id: Int16(product_id))
            } catch {
                //ERROR
            }
        }
    }
}
