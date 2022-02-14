//
//  ViewController.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import UIKit
import CoreData

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var ProdListTable: UITableView!
    
    let urlString = "http://staging.php-dev.in:8844/trainingapp/api/products/getList?product_category_id=1"
    var prodlistdata = [ProductListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProdListTable.delegate = self
        ProdListTable.dataSource = self
        jsonParse {
            self.ProdListTable.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        jsonParse {
            self.ProdListTable.reloadData()
        }
    }
    
    func checkLike(id: Int16) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Prod_item")
        let filter = "\(id)"
        let predicate = NSPredicate(format: "id = %@", filter)
        fetchRequest.predicate = predicate
        var results: [Any]
        var tt: Bool = false
        do {
            results = try context.fetch(fetchRequest)
            if results.isEmpty == true {
                tt = false
            }else{
                tt = true
            }
        } catch  {
            //error
        }
        return tt
    }
    
    func jsonParse(completed: @escaping () -> ()){
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) {(data, response, poop) in
            if let response = response{
                print(response)
            }
            
            if let data = data {
                do{
                    let pdata = try JSONDecoder().decode(ProductListDataProduct.self, from: data)
                    self.prodlistdata = pdata.data
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prodlistdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProdListTable.dequeueReusableCell(withIdentifier: "cell") as! ProdListTableViewCell
        let cellIndex = indexPath.row
        cell.prodList_name.text = "\(prodlistdata[cellIndex].name)"
        cell.prodList_price.text = "Rs. \(prodlistdata[cellIndex].cost)"
        cell.prodList_producer.text = prodlistdata[cellIndex].producer
        cell.prodList_image.downloaded(from: prodlistdata[cellIndex].product_images)
        cell.product_id = prodlistdata[cellIndex].id
        
        if checkLike(id: Int16(prodlistdata[cellIndex].id)) == true {
            cell.prodList_like.isSelected = true
        }else {
            cell.prodList_like.isSelected = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetailViewController") as? DetailViewController
        let cellIndex = indexPath.row
        vc?.prod_id = prodlistdata[cellIndex].id
        vc?.prod_imagev = prodlistdata[cellIndex].product_images
        vc?.prod_namev = prodlistdata[cellIndex].name
        vc?.prod_producerv = prodlistdata[cellIndex].producer
        vc?.prod_ratingv = "\(prodlistdata[cellIndex].rating)"
        vc?.prod_pricev = "\(prodlistdata[cellIndex].cost)"
        vc?.prod_descriptionv = prodlistdata[cellIndex].description
        if checkLike(id: Int16(prodlistdata[cellIndex].id)) == true {
            vc?.prod_likev = true
        }else {
            vc?.prod_likev = false
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
