//
//  Like Checker.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import Foundation
import UIKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class LikeChecker {
    func getItems() {
        do {
            let items = try context.fetch(Prod_item.fetchRequest())
            print(items)
        } catch {
            //error
        }
    }}
