//
//  PatientPrescriptionCell.swift
//  RelaxNow
//
//  Created by Admin on 21/03/21.
//

import UIKit

protocol PatientPrescriptionDelete: class {
    func prescriptionDidSubmit(withNotes: String, prescriptions:[PrescriptionModelNew])
    func openPlanOfActionSheet(for prescriptionIndex:Int)
}

enum PatientPrescriptionCellType:Int {
    case new
    case history
}

class PatientPrescriptionCell: UITableViewCell {
    @IBOutlet weak var viewMedicinesHeaderHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewMedicinesHeader: UIView!
    @IBOutlet weak var viewSubmitHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewSubmit: UIView!
    
    weak var delegate: PatientPrescriptionDelete?
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnSearchMedicine: UIButton!
    @IBOutlet weak var prescriptionTextView: UITextView!
    
    @IBOutlet weak var tableViewPrescriptions: UITableView!
    
    var prescriptions: [PrescriptionModelNew]?
    var numberOfCells:Int {
        print(prescriptions?.count ?? 0)
        return prescriptions?.count ?? 0
    }
    
    var planOfActionPicker:UIPickerView? = nil
    var planOfActionToolbar:UIToolbar? = nil
    var cellType:PatientPrescriptionCellType = .new {
        didSet {
            viewMedicinesHeaderHeight.constant = cellType == .new ? 44 : 0.0
            viewMedicinesHeader.isHidden = cellType == .history
            viewSubmitHeight.constant = cellType == .new ? 40 : 0.0
            prescriptionTextView.isEditable = cellType == .new
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableViewPrescriptions.dataSource = self
        tableViewPrescriptions.delegate = self
        prescriptionTextView.layer.borderWidth = 1.0
        prescriptionTextView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        registerCell()
        
        if UserData.current.role == "Psychiatrist"{
            self.tableViewHeight.constant = 0
            self.searchBarHeightConstraint.constant = 0
        }
        
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

    func configureCellWith(prescriptions: [PrescriptionModelNew]){
        self.prescriptions = prescriptions
        tableViewHeight.constant = CGFloat(140 * numberOfCells)
        self.tableViewPrescriptions.reloadData()
        self.layoutIfNeeded()
        self.prescriptionTextView.text = self.prescriptions?.first?.pRESCRIPTION
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
        if cellType == .new {
            if UserData.current.role == "Psychiatrist"{
                viewSubmit.isHidden = false
            }else{
                viewSubmit.isHidden = numberOfCells <= 0
            }
        }else {
            viewSubmit.isHidden = true
        }
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addMedicationTableCell.rawValue, for: indexPath) as? AddMedicationTableCell
        if let prescription = self.prescriptions?[indexPath.row]{
            cell?.configureCell(with: prescription)
            cell?.delegate = self
        }
        cell?.prescriptionIndex = indexPath.row
        if self.cellType == .new {
            cell?.planOfActionField.inputAccessoryView = planOfActionToolbar
            cell?.planOfActionField.inputView = planOfActionPicker
            cell?.btnDisableCell.isHidden = true
        }else {
            cell?.btnDisableCell.isHidden = false
        }
       
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
    
    
    func didUpdatePriscription(prescriptionData: PrescriptionModelNew) {
        for (index, prescription) in self.prescriptions!.enumerated(){
            if prescription.medicineId == prescriptionData.medicineId{
//                if let addMedicineVC = self.parentContainerViewController as? AddMedicationViewController {
//                    addMedicineVC.prescriptions[index]
//                }
                self.prescriptions?[index] = prescriptionData
            }
        }
    }
    
    
}
