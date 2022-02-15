//
//  Like Checker.swift
//  Neo Product Demo Assignment
//
//  Created by Neosoft on 10/02/22.
//

import Foundation
import UIKit
import CoreData

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

var Like_Checker_Instance: LikeChecker = LikeChecker()

class LikeChecker {
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
    func createItem(id: Int16) throws -> String{
        if id == 0 {
            throw ValidationErrors.emptyID
        }
        let newItem = Prod_item(context: context)
        newItem.id = id
        do {
            try context.save()
        } catch {
            //error
        }
        return "\(id)"
    }
    func deleteItem(id: Int16) throws -> String{
        if id == 0 {
            throw ValidationErrors.emptyID
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Prod_item")
        let filter = "\(id)"
        let predicate = NSPredicate(format: "id = %@", filter)
        fetchRequest.predicate = predicate
        do {
            let results = try context.fetch(fetchRequest)
            print(results[0] as! NSManagedObject)
            context.delete(results[0] as! NSManagedObject)
            try context.save()
        } catch  {
            //error
        }
        return "\(id)"
    }
}

enum ValidationErrors: LocalizedError {
    case emptyID
    case invalidID
    case IDLong
    
    var errorDescription: String? {
        switch self {
        case .emptyID:
            return "ID is Empty"
        case .invalidID:
            return "ID is invalid"
        case .IDLong:
            return "ID is too long"
        }
    }
}
