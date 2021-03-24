

import Foundation
import UIKit

let NSUSER_DEFAULTS = UserDefaults.standard
let appDelegateObj = UIApplication.shared.delegate as! AppDelegate
public typealias CallBack = ()->()
let SERVER_MESSAGE = "There is a problem with the server, please try again later."
let BASE_URL = "https://app.biyah.pk/app1/"




//struct CellIdentifier {
//    static let appointmentListCell = "AppointmentListCell"
//}

enum CellIdentifier:String{
    case appointmentListCell = "AppointmentListCell"
    case addMedicationTableCell = "AddMedicationTableCell"
    case patientTableViewCell = "PatientTableViewCell"
}

// MARK: - Screen size and device type

//iPhone Screensize
struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

//iPhone devicetype
struct DeviceType {
    static let iOS                  = "2"
    static let IS_IPHONE_4_OR_LESS  = ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X          = ScreenSize.SCREEN_HEIGHT == 812.0
    
    static let IS_IPHONE_XMAX          = ScreenSize.SCREEN_HEIGHT == 896.0
    static let IS_PAD               = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
}
