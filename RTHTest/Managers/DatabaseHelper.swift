//
//  DatabaseHelper.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/2/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {

    private static var instance: DatabaseHelper!

    static func getInstance() -> DatabaseHelper {
        if instance == nil {
            instance = DatabaseHelper()
        }

        return instance
    }

    private override init() {
        super.init()

    }

    func savePrice(_ price: Price) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        do {

            let context = appDelegate.persistentContainer.viewContext

            let entity = NSEntityDescription.entity(forEntityName: "PriceModel", in: context)

            let fetchRequest: NSFetchRequest<PriceModel> = PriceModel.fetchRequest()
            let searchResults = try context.fetch(fetchRequest)

            var transc: NSManagedObject!
            var isUpdate = false
            for trans in searchResults as [NSManagedObject] {
                let id = trans.value(forKey: "id") as? String

                if id == price.date {
                    transc = trans
                    isUpdate = true
                    break
                }
            }

            if !isUpdate && entity != nil {
                transc = NSManagedObject(entity: entity!, insertInto: context) //swiftlint:disable:this force_unwrapping
            }

            if transc != nil {
                //set the entity values
                transc.setValue(price.date, forKey: "id")
                transc.setValue(price.date, forKey: "date")
                transc.setValue(price.amount, forKey: "amount")

                //save the object
                try context.save()
                print("saved!")
            }
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        } catch {

        }
    }

    func getPrices() -> [Price]? {

        let fetchRequest: NSFetchRequest<PriceModel> = PriceModel.fetchRequest()

        do {
            //go get the results
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return nil
            }

            let context = appDelegate.persistentContainer.viewContext

            let searchResults = try context.fetch(fetchRequest)

            var prices: [Price] = []

            for trans in searchResults as [NSManagedObject] {
                let price = Price()
                price.id = trans.value(forKey: "id") as? String
                price.date = trans.value(forKey: "date") as? String
                price.amount = trans.value(forKey: "amount") as? String
                prices.append(price)
            }
            return prices
        } catch {
            print("Error with request: \(error)")
        }
        return nil
    }
}
