//
//  Price.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/2/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit
import ObjectMapper

class Price: Mappable {

    var id: String?
    var amount: String?
    var date: String?

    init() {
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        amount <- map["amount"]
        date <- map["date"]
    }
}
