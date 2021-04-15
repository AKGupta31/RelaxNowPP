//
//  AddMedicationTableCell.swift
//  RelaxNow
//
//  Created by Pritrum on 06/03/21.
//

import UIKit

protocol AddMedicationDelegate: class {
    func didUpdatePriscription(prescriptionData: PrescriptionModelNew)
    func openPlanOfActionSheet(for prescriptionIndex:Int)
}
class AddMedicationTableCell: UITableViewCell {
   
    @IBOutlet weak var btnDisableCell: UIButton!
    weak var delegate: AddMedicationDelegate?
    
    @IBOutlet weak var planOfActionField: UITextField!
    
    
    @IBOutlet weak var viewPlanOfAction: UIView!
    
    @IBOutlet weak var btnPlanofAction: UIButton!
    
    @IBOutlet weak var potencyField: UITextField!
    @IBOutlet weak var doseField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var prescriptionData: PrescriptionModelNew?
    var prescriptionIndex:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
//        setUpUI()
        planOfActionField.delegate = self
        setUpUI()
    }
    
    
    private func setUpUI(){
        potencyField.layer.masksToBounds = true
        potencyField.layer.masksToBounds = true
        guard let borderColor = UIColor(named: "BorderColor") else {return}
        potencyField.layer.borderColor = borderColor.cgColor
        doseField.layer.borderColor = borderColor.cgColor
        durationTextField.layer.borderColor = borderColor.cgColor
        viewPlanOfAction.layer.borderColor = borderColor.cgColor
        doseField.layer.borderWidth = 1
        potencyField.layer.borderWidth = 1
        durationTextField.layer.borderWidth = 1
        viewPlanOfAction.layer.borderWidth = 1
    }
    
    
    func configureCell(with prescription: PrescriptionModelNew){
        self.prescriptionData = prescription
        self.titleLabel.text = prescription.mEDICINE
        self.planOfActionField.text = prescription.pLANOFACTION
        self.durationTextField.text = prescription.dURATION
        self.doseField.text = prescription.dOSE
        self.potencyField.text = prescription.pOTENCY
    }
    
    @IBAction func actionPlanOfAction(_ sender: UIButton) {
//        let planOfAction = delegate?.didSelectPlanOfAction(prescriptionData: self.prescriptionData!, button: sender)
//        btnPlanofAction.setTitle(planOfAction, for: .normal)
    }
    
    
}
extension AddMedicationTableCell: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == potencyField{
            self.prescriptionData?.pOTENCY = textField.text
        }else if textField == doseField{
            self.prescriptionData?.dOSE = textField.text
        }else if textField == durationTextField{
            self.prescriptionData?.dURATION = textField.text
        }else if textField == planOfActionField {
            return
        }
        if let prescriptionData =  self.prescriptionData {
            delegate?.didUpdatePriscription(prescriptionData: prescriptionData)
        }
      
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("text field")
        if textField == planOfActionField {
            delegate?.openPlanOfActionSheet(for: self.prescriptionIndex)
        }
       
    }
}
