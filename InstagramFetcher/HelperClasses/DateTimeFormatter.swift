//
//  DateTimeFormatter.swift
//  InstagramFetcher
//
//  Created by Amandeep Singh on 24/04/17.
//  Copyright © 2017 Amandeep Singh. All rights reserved.
//

import UIKit

class DateTimeFormatter: NSObject {
    class var sharedInstance :DateTimeFormatter {
        struct Singleton {
            static let instance = DateTimeFormatter()
        }
        return Singleton.instance
    }
    func getDateFromMiliseconds(_ miliseconds:Int64) -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(miliseconds))
        return (date as NSDate) as Date
    }
    func getStringFromDate(_ creationDate:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let dateString = dateFormatter.string(from: creationDate as Date)
        return dateString
    }
}
