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
        checkLike()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeBtnAction(_ sender: Any) {
        if prodList_like.isSelected == true {
            prodList_like.isSelected = false
        }else{
            prodList_like.isSelected = true
            deleteItem(id: 444)
            //createItem(id: Int16(product_id))
        }
    }
    func checkLike() {
        //
    }
    func createItem(id: Int16){
        let newItem = Prod_item(context: context)
        newItem.id = id
        do {
            try context.save()
        } catch {
            //error
        }
    }
    func deleteItem(id: Int16){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Prod_item")
        let filter = "\(id)"
        let predicate = NSPredicate(format: "id = %@", filter)
        fetchRequest.predicate = predicate
        print(fetchRequest)
        do {
            let results = try context.fetch(fetchRequest)
            print(results)
        } catch  {
            //error
        }
    }
}
