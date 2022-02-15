//
//  DetailViewController.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import UIKit

class DetailViewController: UIViewController {
        
    @IBOutlet weak var prod_image: UIImageView!
    @IBOutlet weak var prod_name: UILabel!
    @IBOutlet weak var prod_producer: UILabel!
    @IBOutlet weak var prod_price: UILabel!
    @IBOutlet weak var prod_rating: UILabel!
    @IBOutlet weak var prod_description: UITextView!
    @IBOutlet weak var prod_like: UIButton!
    
    var Like_Checker_Service: LikeChecker? = nil
    
    var prod_imagev: String = ""
    var prod_namev: String = ""
    var prod_producerv: String = ""
    var prod_pricev: String = ""
    var prod_ratingv: String = ""
    var prod_descriptionv: String = ""
    var prod_likev: Bool = true
    var prod_id: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        prod_image.downloaded(from: prod_imagev)
        prod_name.text = prod_namev
        prod_producer.text = prod_producerv
        prod_price.text = prod_pricev
        prod_rating.text = prod_ratingv
        prod_description.text = prod_descriptionv
        if prod_likev == true {
            prod_like.isSelected = true
        }else{
            prod_like.isSelected = false
        }
    }

    @IBAction func likeBtnAction(_ sender: Any) {
        guard let LCS = Like_Checker_Service else {
            return
        }
        if prod_like.isSelected == true {
            do {
                try LCS.deleteItem(id: Int16(prod_id))
            } catch {
                //ERROR
            }
            prod_like.isSelected = false
        }else{
            do {
                try LCS.createItem(id: Int16(prod_id))
            } catch {
                //ERROR
            }
            prod_like.isSelected = true
        }
    }
}
