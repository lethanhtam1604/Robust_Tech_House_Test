//
//  Global.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/1/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit

enum WorkFlow: Int {

    case splashScreen = 0
    case mainScreen = 1
    case nothing = -1
}

class Global {

    static let colorMain = UIColor(0x0F85D1)
    static let colorBg = UIColor(0xDCF2FF)
    static let colorLine = UIColor(0x9DCDEC)

    static var currentWorkFlow = WorkFlow.splashScreen.hashValue
}

struct ScreenSize {

    static let SCREENWIDTH = UIScreen.main.bounds.size.width
    static let SCREENHEIGHT = UIScreen.main.bounds.size.height
    static let SCREENMAXLENGTH = max(ScreenSize.SCREENWIDTH, ScreenSize.SCREENHEIGHT)
    static let SCREENMINLENGTH = min(ScreenSize.SCREENWIDTH, ScreenSize.SCREENHEIGHT)
}

struct DeviceType {

    static let ISIPHONE4ORLESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREENMAXLENGTH < 568.0
    static let ISIPHONE5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREENMAXLENGTH == 568.0
    static let ISIPHONE6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREENMAXLENGTH == 667.0
    static let ISIPHONE6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREENMAXLENGTH == 736.0
    static let ISIPHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let ISIPAD = UIDevice.current.userInterfaceIdiom == .pad
}
