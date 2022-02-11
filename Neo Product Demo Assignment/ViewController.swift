//
//  ViewController.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import UIKit

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
        cell.prodList_name.text = prodlistdata[cellIndex].name
        cell.prodList_price.text = "Rs. \(prodlistdata[cellIndex].cost)"
        cell.prodList_producer.text = prodlistdata[cellIndex].producer
        cell.prodList_image.downloaded(from: prodlistdata[cellIndex].product_images)
        cell.product_id = prodlistdata[cellIndex].id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetailViewController") as? DetailViewController
        vc?.prod_id = prodlistdata[indexPath.row].id
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
