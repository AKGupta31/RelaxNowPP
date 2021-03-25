

import Foundation
struct PatientData : Codable {
	let rN_APPOINTMENT_ID : Int?
	let pEOPLE_ID : Int?
	let cUSTOMER_ID : Int?
	let bOOKING_DATE : String?
	let aPPOINTMENT_DATE : String?
	let aPPOINTMENT_TIME : String?
	let fOLLOWUP_DATE : String?
	let fOLLOWUP_TIME : String?
	let sTATUS : String?
	let rELATIONSHIP_NUMBER : String?
	let rN_CUSTOMER_Prefix : String?
	let rN_CUSTOMER_FIRST_NAME : String?
	let rN_CUSTOMER_MIDDLE_NAME : String?
	let rN_CUSTOMER_LAST_NAME : String?
	let rN_CUSTOMER_MOBILE : String?
	let rN_CUSTOMER_EMAIL : String?
	let rN_CUSTOMER_ADDRESS : String?
	let cITIZEN_COUNTRY_ID : Int?
	let rN_CUSTOMER_ : Int?
	let uID_NUMBER : Int?
	let gENDER_ID : Int?
	let gENDER : String?

	enum CodingKeys: String, CodingKey {

		case rN_APPOINTMENT_ID = "RN_APPOINTMENT_ID"
		case pEOPLE_ID = "PEOPLE_ID"
		case cUSTOMER_ID = "CUSTOMER_ID"
		case bOOKING_DATE = "BOOKING_DATE"
		case aPPOINTMENT_DATE = "APPOINTMENT_DATE"
		case aPPOINTMENT_TIME = "APPOINTMENT_TIME"
		case fOLLOWUP_DATE = "FOLLOWUP_DATE"
		case fOLLOWUP_TIME = "FOLLOWUP_TIME"
		case sTATUS = "STATUS"
		case rELATIONSHIP_NUMBER = "RELATIONSHIP_NUMBER"
		case rN_CUSTOMER_Prefix = "RN_CUSTOMER_Prefix"
		case rN_CUSTOMER_FIRST_NAME = "RN_CUSTOMER_FIRST_NAME"
		case rN_CUSTOMER_MIDDLE_NAME = "RN_CUSTOMER_MIDDLE_NAME"
		case rN_CUSTOMER_LAST_NAME = "RN_CUSTOMER_LAST_NAME"
		case rN_CUSTOMER_MOBILE = "RN_CUSTOMER_MOBILE"
		case rN_CUSTOMER_EMAIL = "RN_CUSTOMER_EMAIL"
		case rN_CUSTOMER_ADDRESS = "RN_CUSTOMER_ADDRESS"
		case cITIZEN_COUNTRY_ID = "CITIZEN_COUNTRY_ID"
		case rN_CUSTOMER_ = "RN_CUSTOMER_"
		case uID_NUMBER = "UID_NUMBER"
		case gENDER_ID = "GENDER_ID"
		case gENDER = "GENDER"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rN_APPOINTMENT_ID = try values.decodeIfPresent(Int.self, forKey: .rN_APPOINTMENT_ID)
		pEOPLE_ID = try values.decodeIfPresent(Int.self, forKey: .pEOPLE_ID)
		cUSTOMER_ID = try values.decodeIfPresent(Int.self, forKey: .cUSTOMER_ID)
		bOOKING_DATE = try values.decodeIfPresent(String.self, forKey: .bOOKING_DATE)
		aPPOINTMENT_DATE = try values.decodeIfPresent(String.self, forKey: .aPPOINTMENT_DATE)
		aPPOINTMENT_TIME = try values.decodeIfPresent(String.self, forKey: .aPPOINTMENT_TIME)
		fOLLOWUP_DATE = try values.decodeIfPresent(String.self, forKey: .fOLLOWUP_DATE)
		fOLLOWUP_TIME = try values.decodeIfPresent(String.self, forKey: .fOLLOWUP_TIME)
		sTATUS = try values.decodeIfPresent(String.self, forKey: .sTATUS)
		rELATIONSHIP_NUMBER = try values.decodeIfPresent(String.self, forKey: .rELATIONSHIP_NUMBER)
		rN_CUSTOMER_Prefix = try values.decodeIfPresent(String.self, forKey: .rN_CUSTOMER_Prefix)
		rN_CUSTOMER_FIRST_NAME = try values.decodeIfPresent(String.self, forKey: .rN_CUSTOMER_FIRST_NAME)
		rN_CUSTOMER_MIDDLE_NAME = try values.decodeIfPresent(String.self, forKey: .rN_CUSTOMER_MIDDLE_NAME)
		rN_CUSTOMER_LAST_NAME = try values.decodeIfPresent(String.self, forKey: .rN_CUSTOMER_LAST_NAME)
		rN_CUSTOMER_MOBILE = try values.decodeIfPresent(String.self, forKey: .rN_CUSTOMER_MOBILE)
		rN_CUSTOMER_EMAIL = try values.decodeIfPresent(String.self, forKey: .rN_CUSTOMER_EMAIL)
		rN_CUSTOMER_ADDRESS = try values.decodeIfPresent(String.self, forKey: .rN_CUSTOMER_ADDRESS)
		cITIZEN_COUNTRY_ID = try values.decodeIfPresent(Int.self, forKey: .cITIZEN_COUNTRY_ID)
		rN_CUSTOMER_ = try values.decodeIfPresent(Int.self, forKey: .rN_CUSTOMER_)
		uID_NUMBER = try values.decodeIfPresent(Int.self, forKey: .uID_NUMBER)
		gENDER_ID = try values.decodeIfPresent(Int.self, forKey: .gENDER_ID)
		gENDER = try values.decodeIfPresent(String.self, forKey: .gENDER)
	}
    
    var isTodaysAppointment :Bool{
        guard let dateStr = self.aPPOINTMENT_DATE else {return false}
        guard let date = DateHelper.shared.getDate(from: dateStr) else {
            return false
        }
        if Calendar.current.compare(date, to: Date(), toGranularity: .day) == .orderedSame {
            return true
        }
        return false
    }

}
