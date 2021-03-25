//
//  PrescriptionModel.swift
//  RelaxNow
//
//  Created by Admin on 20/03/21.
//

import Foundation

struct PrescriptionModel {
    var medicineName:String? = nil
    var medicineId:Int? = nil
    var potency:String? = nil
    var dose:String? = nil
    var duration: String? = nil
    var action: String = "None"
    var createdBy:String? = nil
    
    init(medicine:MedicineModel) {
        self.medicineName = medicine.name
        self.medicineId = medicine.id
    }
    
    static func getPrescriptions(medicines:[MedicineModel]) -> [PrescriptionModel] {
        var prescriptions = [PrescriptionModel]()
        medicines.forEach { (medicineModel) in
            prescriptions.append(PrescriptionModel(medicine: medicineModel))
        }
        return prescriptions
    }
    
}

