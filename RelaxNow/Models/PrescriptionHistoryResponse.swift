//
//  PrescriptionHistoryResponse.swift
//  RelaxNow
//
//  Created by Admin on 27/03/21.
//


import Foundation
struct PrescriptionHistoryResponse : Codable {
    let status : Int?
    let message : String?
    let prescriptions : [PrescriptionModelNew]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case prescriptions = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        prescriptions = try values.decodeIfPresent([PrescriptionModelNew].self, forKey: .prescriptions)
    }

}

struct PrescriptionModelNew : Codable {
    var iD : Int?
    var pEOPLE_ID : Int?
    var cUSTOMER_ID : Int?
    var bOOKING_DATE : String?
    var aPPOINTMENT_DATE : String?
    var aPPOINTMENT_TIME : String?
    var fOLLOWUP_DATE : String?
    var fOLLOWUP_TIME : String?
    var sTATUS : String?
    var pAYMENT_TYPE : String?
    var pAYMENT_AMMOUNT : Int?
    var pAYMENT_DATE : String?
    var pAYMENT_RECEIPT : String?
    var pRESCRIPTION : String?
    var mEDICINE : String?
    var pOTENCY : String?
    var dOSE : String?
    var dURATION : String?
    var pLANOFACTION : String = "None"
    var medicineId:Int? = nil
    var createdBy:String? = nil
    var prescriptionId:Int?
//    var medicineName:String? = nil
   
//    var potency:String? = nil
//    var dose:String? = nil
//    var duration: String? = nil
//    var action: String = "None"
    
    
   
    

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case pEOPLE_ID = "PEOPLE_ID"
        case cUSTOMER_ID = "CUSTOMER_ID"
        case bOOKING_DATE = "BOOKING_DATE"
        case aPPOINTMENT_DATE = "APPOINTMENT_DATE"
        case aPPOINTMENT_TIME = "APPOINTMENT_TIME"
        case fOLLOWUP_DATE = "FOLLOWUP_DATE"
        case fOLLOWUP_TIME = "FOLLOWUP_TIME"
        case sTATUS = "STATUS"
        case pAYMENT_TYPE = "PAYMENT_TYPE"
        case pAYMENT_AMMOUNT = "PAYMENT_AMMOUNT"
        case pAYMENT_DATE = "PAYMENT_DATE"
        case pAYMENT_RECEIPT = "PAYMENT_RECEIPT"
        case pRESCRIPTION = "PRESCRIPTION"
        case mEDICINE = "MEDICINE"
        case pOTENCY = "POTENCY"
        case dOSE = "DOSE"
        case dURATION = "DURATION"
        case pLANOFACTION = "PLANOFACTION"
        case prescriptionId = "PRESCRIPTION_ID"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(Int.self, forKey: .iD)
        pEOPLE_ID = try values.decodeIfPresent(Int.self, forKey: .pEOPLE_ID)
        cUSTOMER_ID = try values.decodeIfPresent(Int.self, forKey: .cUSTOMER_ID)
        bOOKING_DATE = try values.decodeIfPresent(String.self, forKey: .bOOKING_DATE)
        aPPOINTMENT_DATE = try values.decodeIfPresent(String.self, forKey: .aPPOINTMENT_DATE)
        aPPOINTMENT_TIME = try values.decodeIfPresent(String.self, forKey: .aPPOINTMENT_TIME)
        fOLLOWUP_DATE = try values.decodeIfPresent(String.self, forKey: .fOLLOWUP_DATE)
        fOLLOWUP_TIME = try values.decodeIfPresent(String.self, forKey: .fOLLOWUP_TIME)
        sTATUS = try values.decodeIfPresent(String.self, forKey: .sTATUS)
        pAYMENT_TYPE = try values.decodeIfPresent(String.self, forKey: .pAYMENT_TYPE)
        pAYMENT_AMMOUNT = try values.decodeIfPresent(Int.self, forKey: .pAYMENT_AMMOUNT)
        pAYMENT_DATE = try values.decodeIfPresent(String.self, forKey: .pAYMENT_DATE)
        pAYMENT_RECEIPT = try values.decodeIfPresent(String.self, forKey: .pAYMENT_RECEIPT)
        pRESCRIPTION = try values.decodeIfPresent(String.self, forKey: .pRESCRIPTION)
        mEDICINE = try values.decodeIfPresent(String.self, forKey: .mEDICINE)
        pOTENCY = try values.decodeIfPresent(String.self, forKey: .pOTENCY)
        dOSE = try values.decodeIfPresent(String.self, forKey: .dOSE)
        dURATION = try values.decodeIfPresent(String.self, forKey: .dURATION)
        pLANOFACTION = try values.decodeIfPresent(String.self, forKey: .pLANOFACTION) ?? "None"
        prescriptionId = try values.decodeIfPresent(Int.self, forKey: .prescriptionId)
    }

    //Comnining of prescrition model into prescription model new
    init(medicine:MedicineModel) {
        self.mEDICINE = medicine.name
        self.medicineId = medicine.id
    }
    
    static func getPrescriptions(medicines:[MedicineModel]) -> [PrescriptionModelNew] {
        var prescriptions = [PrescriptionModelNew]()
        medicines.forEach { (medicineModel) in
            prescriptions.append(PrescriptionModelNew(medicine: medicineModel))
        }
        return prescriptions
    }
    
    var isAllFieldsFilled:(Bool,String) {
        if pOTENCY?.isEmpty ?? true {
            return (false,"Potency is missing")
        }else if dOSE?.isEmpty ?? true {
            return (false,"Dose is missing")
        }else if dURATION?.isEmpty ?? true {
            return (false,"Duration is empty")
        }
        return (true,"")
    }
    
}
