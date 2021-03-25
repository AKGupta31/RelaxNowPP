//
//  AddMedicationTableCell.swift
//  RelaxNow
//
//  Created by Pritrum on 06/03/21.
//

import UIKit

protocol AddMedicationDelegate: class {
    func didUpdatePriscription(prescriptionData: PrescriptionModel)
    func openPlanOfActionSheet(for prescriptionIndex:Int)
}
class AddMedicationTableCell: UITableViewCell {
   
    weak var delegate: AddMedicationDelegate?
    @IBOutlet weak var addNoteTextField: UITextField!
    
    @IBOutlet weak var planOfActionField: UITextField!
    
    
    @IBOutlet weak var viewPlanOfAction: UIView!
    
    @IBOutlet weak var btnPlanofAction: UIButton!
    
    @IBOutlet weak var perDayCountTextField: UITextField!
    @IBOutlet weak var numberOfDayCountTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var prescriptionData: PrescriptionModel?
    var prescriptionIndex:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        viewPlanOfAction.layer.borderWidth = 1
        viewPlanOfAction.layer.borderColor = UIColor.black.cgColor

        // Initialization code
//        setUpUI()
        planOfActionField.delegate = self
    }
    
    
    private func setUpUI(){
        perDayCountTextField.layer.masksToBounds = true
        addNoteTextField.layer.masksToBounds = true
        perDayCountTextField.layer.masksToBounds = true

        perDayCountTextField.layer.borderColor = UIColor.systemGray.cgColor
        numberOfDayCountTextField.layer.borderColor = UIColor.systemGray.cgColor
        addNoteTextField.layer.borderColor = UIColor.systemGray.cgColor
        perDayCountTextField.layer.borderWidth = 1
        numberOfDayCountTextField.layer.borderWidth = 1
        addNoteTextField.layer.borderWidth = 1
        
    }
    
    
    func configureCell(with prescription: PrescriptionModel){
        self.prescriptionData = prescription
        self.titleLabel.text = prescription.medicineName
        self.planOfActionField.text = prescription.action
    }
    
    @IBAction func actionPlanOfAction(_ sender: UIButton) {
//        let planOfAction = delegate?.didSelectPlanOfAction(prescriptionData: self.prescriptionData!, button: sender)
//        btnPlanofAction.setTitle(planOfAction, for: .normal)
    }
    
    
}
extension AddMedicationTableCell: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == perDayCountTextField{
            self.prescriptionData?.potency = textField.text
        }else if textField == numberOfDayCountTextField{
            self.prescriptionData?.dose = textField.text
        }else if textField == durationTextField{
            self.prescriptionData?.duration = textField.text
        }
        self.prescriptionData?.action = "None"
        if let prescriptionData =  self.prescriptionData {
            delegate?.didUpdatePriscription(prescriptionData: prescriptionData)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("text field")
        delegate?.openPlanOfActionSheet(for: self.prescriptionIndex)
    }
}
