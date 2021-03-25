//
//  PatientPrescriptionCell.swift
//  RelaxNow
//
//  Created by Admin on 21/03/21.
//

import UIKit

protocol PatientPrescriptionDelete: class {
    func prescriptionDidSubmit(withNotes: String, prescriptions:[PrescriptionModel])
    func openPlanOfActionSheet(for prescriptionIndex:Int)
}

class PatientPrescriptionCell: UITableViewCell {

    
    @IBOutlet weak var viewSubmit: UIView!
    
    weak var delegate: PatientPrescriptionDelete?
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnSearchMedicine: UIButton!
    @IBOutlet weak var prescriptionTextView: UITextView!
    
    @IBOutlet weak var tableViewPrescriptions: UITableView!
    
    var prescriptions: [PrescriptionModel]?
    var numberOfCells:Int {
        prescriptions?.count ?? 0
    }
    
    var planOfActionPicker:UIPickerView? = nil
    var planOfActionToolbar:UIToolbar? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableViewPrescriptions.dataSource = self
        tableViewPrescriptions.delegate = self
        prescriptionTextView.layer.borderWidth = 1.0
        prescriptionTextView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        registerCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        tableViewHeight.constant = CGFloat(140 * numberOfCells)
        self.layoutIfNeeded()
        // Configure the view for the selected state
    }
    
    func registerCell(){
        tableViewPrescriptions.registerTableCell(identifier: .addMedicationTableCell)
    }

    func configureCellWith(prescriptions: [PrescriptionModel]){
        self.prescriptions = prescriptions
        tableViewHeight.constant = CGFloat(140 * numberOfCells)
        self.tableViewPrescriptions.reloadData()
        self.layoutIfNeeded()
    }
    
    @IBAction func submitPrescriptionWithMedicationButtonAction(_ sender: UIButton) {
        let notes = prescriptionTextView.text ?? ""
        if let prescriptions = self.prescriptions {
            self.delegate?.prescriptionDidSubmit(withNotes: notes, prescriptions: prescriptions)
        }
    }
}

extension PatientPrescriptionCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewSubmit.isHidden = numberOfCells <= 0
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addMedicationTableCell.rawValue, for: indexPath) as? AddMedicationTableCell
        if let prescription = self.prescriptions?[indexPath.row]{
            cell?.configureCell(with: prescription)
            cell?.delegate = self
        }
        cell?.prescriptionIndex = indexPath.row
        cell?.planOfActionField.inputAccessoryView = planOfActionToolbar
        cell?.planOfActionField.inputView = planOfActionPicker
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
}

extension PatientPrescriptionCell: AddMedicationDelegate{
    func openPlanOfActionSheet(for prescriptionIndex: Int) {
        delegate?.openPlanOfActionSheet(for: prescriptionIndex)
    }
    
    
    func didUpdatePriscription(prescriptionData: PrescriptionModel) {
        for (index, prescription) in self.prescriptions!.enumerated(){
            if prescription.medicineId == prescriptionData.medicineId{
                self.prescriptions?[index] = prescriptionData
            }
        }
    }
    
    
}
