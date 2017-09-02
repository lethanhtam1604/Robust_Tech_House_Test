//
//  APIHelper.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/2/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class APIHelper {

    static func getPrices(completion: @escaping (_ response: Response, _ prices: [Price]?) -> Void ) {

        Alamofire.request(Router.getPrices()).responseArray(completionHandler: { (response: DataResponse<[Price]>) in
            if let error = response.error {
                print("error: \(error.localizedDescription)")
                completion(Response(error.localizedDescription, false), nil)
            }
            if let prices = response.result.value {
                completion(Response(), prices)
            }
        })
    }

    static func othersApiHere() {

    }
}
