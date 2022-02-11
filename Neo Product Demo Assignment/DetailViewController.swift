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
    
    var prod_id: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func likeBtnAction(_ sender: Any) {
        if prod_like.isSelected == true {
            prod_like.isSelected = false
        }else{
            prod_like.isSelected = true
        }
    }
}
