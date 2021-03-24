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
