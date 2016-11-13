//
//  Restaurant.swift
//  RestaurantHub
//
//  Created by Shrujan Kalidindi on 6/23/16.
//  Copyright © 2016 Shrujan Kalidindi. All rights reserved.
//

import UIKit

class Restaurant: NSObject, NSCoding {
    
    var name: String?
    var bill: String?
    var date: String?
    
    init(name: String, bill: String, date: String) {
        super.init()
        self.name = name
        self.bill = bill
        self.date = date
    }
    
    required init(coder aDecoder: NSCoder) {
        if let nameDecoded = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = nameDecoded
        }
        
        if let billDecoded = aDecoder.decodeObject(forKey: "bill") as? String {
            self.bill = billDecoded
        }
        
        if let dateDecoded = aDecoder.decodeObject(forKey: "date") as? String {
            self.date = dateDecoded
        }
    }
    
    func encode(with aCoder: NSCoder) {
        if let nameEncoded = self.name {
            aCoder.encode(nameEncoded, forKey: "name")
        }
        if let billEncoded = self.bill {
            aCoder.encode(billEncoded, forKey: "bill")
        }
        if let dateEncoded = self.date {
            aCoder.encode(dateEncoded, forKey: "date")
        }
    }

}
