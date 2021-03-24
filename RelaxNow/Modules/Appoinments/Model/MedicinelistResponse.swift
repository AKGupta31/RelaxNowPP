

import Foundation
struct MedicinelistResponse : Codable {
	let status : Int?
	let message : String?
	let medicines : [MedicineModel]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case message = "message"
		case medicines = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		message = try values.decodeIfPresent(String.self, forKey: .message)
		medicines = try values.decodeIfPresent([MedicineModel].self, forKey: .medicines)
	}

}


struct MedicineModel : Codable {
    let description : String?
    let drugResistant : String?
    let medicine_groupid : String?
    let sortOrder : String?
    let active : Int?
    let chemicalFormulationGroupId : String?
    let id : Int?
    let name : String?
    let group_Name : String?
    let group_Id : Int?
    let formulation_Id : Int?
    let formulation_Name : String?
    
    var isSelected = false

    enum CodingKeys: String, CodingKey {

        case description = "Description"
        case drugResistant = "DrugResistant"
        case medicine_groupid = "medicine_groupid"
        case sortOrder = "SortOrder"
        case active = "Active"
        case chemicalFormulationGroupId = "ChemicalFormulationGroupId"
        case id = "Id"
        case name = "Name"
        case group_Name = "Group_Name"
        case group_Id = "Group_Id"
        case formulation_Id = "Formulation_Id"
        case formulation_Name = "Formulation_Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        drugResistant = try values.decodeIfPresent(String.self, forKey: .drugResistant)
        medicine_groupid = try values.decodeIfPresent(String.self, forKey: .medicine_groupid)
        sortOrder = try values.decodeIfPresent(String.self, forKey: .sortOrder)
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        chemicalFormulationGroupId = try values.decodeIfPresent(String.self, forKey: .chemicalFormulationGroupId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        group_Name = try values.decodeIfPresent(String.self, forKey: .group_Name)
        group_Id = try values.decodeIfPresent(Int.self, forKey: .group_Id)
        formulation_Id = try values.decodeIfPresent(Int.self, forKey: .formulation_Id)
        formulation_Name = try values.decodeIfPresent(String.self, forKey: .formulation_Name)
    }

}
