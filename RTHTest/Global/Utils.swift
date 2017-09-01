//
//  Utils.swift
//  RTHTest
//
//  Created by Thanh-Tam Le on 9/1/17.
//  Copyright © 2017 Tam. All rights reserved.
//

import UIKit
import SystemConfiguration

open class Utils {

    static func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    static func getDayFromDate(date: String) -> String {
        let calendar = Calendar.current

        if let newDate = stringToDate(string: date) {
            let day = calendar.component(.day, from: newDate)

            return String(day)
        }

        return ""
    }

    static func getWeekdayFromDate(date: String) -> String {

        let calendar = Calendar.current

        if let newDate = stringToDate(string: date) {
            let weekday = calendar.component(.weekday, from: newDate)
            let dateFormatter = getDateFormatter()

            return dateFormatter.weekdaySymbols[weekday - 1]
        }

        return ""
    }

    static func getMonthFromDate(date: String) -> String {

        let calendar = Calendar.current

        if let newDate = stringToDate(string: date) {
            let weekday = calendar.component(.month, from: newDate)
            let dateFormatter = getDateFormatter()

            return dateFormatter.monthSymbols[weekday - 1]
        }
        return ""
    }

    static func getYearFromDate(date: String) -> String {

        let calendar = Calendar.current

        if let newDate = stringToDate(string: date) {
            let year = calendar.component(.year, from: newDate)

            return String(year)
        }

        return ""
    }

    static func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = getDateFormatter()

        let result = dateFormatter.string(from: date)

        return result
    }

    static private func stringToDate(string: String) -> Date? {
        let dateFormatter = getDateFormatter()

        let date = dateFormatter.date(from: string)
        return date
    }

    static private func dateToString(date: Date) -> String {
        let dateFormatter = getDateFormatter()

        let result = dateFormatter.string(from: date)
        return result
    }

    static private func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "EEEE, d MMMM, yyyy"

        return dateFormatter
    }
}
