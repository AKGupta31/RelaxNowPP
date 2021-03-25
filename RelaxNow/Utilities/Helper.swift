//
//  Helper.swift
//  RelaxNow
//
//  Created by Pritrum on 10/03/21.
//

import UIKit
class Helper: NSObject{
    
    static func dispatchDelay(deadLine: DispatchTime , execute : @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: deadLine, execute: execute)
    }
    static func  dispatchMain(execute : @escaping () -> Void) {
        DispatchQueue.main.async(execute: execute)
    }
    static func dispatchBackground(execute : @escaping () -> Void) {
        DispatchQueue.global().async(execute: execute)
    }
    static func dispatchMainAfter(time : DispatchTime , execute :@escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: time, execute: execute)
    }
    
    
}

class DateHelper:NSObject {
    
    static let shared = DateHelper()
    func getCurrentDate(format:String = "dd, MMM yyyy",date:Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getCurrentDate(format:String = "dd, MMM yyyy",dateStr:String,inputDateFormat:String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = inputDateFormat
        guard let date = formatter.date(from: dateStr) else {return ""}
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = format
        return newFormatter.string(from: date)
    }
    
    func getDate(from dateString:String,format:String = "yyyy-MM-dd") -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
}
