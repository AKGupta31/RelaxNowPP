//
//  AddMedicationViewController.swift
//  RelaxNow
//
//  Created by Pritrum on 06/03/21.
//

import UIKit
import SwiftSpinner

class AddMedicationViewController: UIViewController {
    @IBOutlet weak var tableViewPatientDetails: UITableView!
    
    @IBOutlet weak var viewForPicker: UIView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePicButton: UIButton!
    
    @IBOutlet weak var madicationListTableView: UITableView!
    @IBOutlet weak var addPrescriptionTextView: UITextView!
    
    @IBOutlet weak var planOfActionPicker: UIPickerView!
    let planOfActionValues = ["None", "Discontinue", "FIXED","Worsened"]
    
    
    @IBOutlet weak var pickerViewBottonConstraint: NSLayoutConstraint!
    var prescriptions = [PrescriptionModelNew]()
    var patientData: PatientData?
    var docTypePicker: UIPickerView!
    var toolBar:UIToolbar!
    
    var prescriptionIndexToBeUpdated = 0
//    var previousPrescriptions = [PrescriptionModelNew]()
    var keys = [String]()
    var keyValuePrescriptions = [String:[PrescriptionModelNew]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        tableViewPatientDetails.delegate = self
        tableViewPatientDetails.dataSource = self
        showPicker()
        viewForPicker.isHidden = true
        getPreviousPrescriptions()
    }
    
    func filterData(prescriptions:[PrescriptionModelNew]){
        prescriptions.forEach { (model) in
            let prescriptionId = model.prescriptionId?.description ?? "0"
            if keys.contains(prescriptionId){
                var previousArray = keyValuePrescriptions[prescriptionId]
                previousArray?.append(model)
                keyValuePrescriptions[prescriptionId] = previousArray
            }else {
                keys.append(prescriptionId)
                keyValuePrescriptions[prescriptionId] = [model]
            }
        }
        self.tableViewPatientDetails.reloadData()
    }
    
    
    
    //MARK:- Helper Methods
    
    private func setUpUI(){
        profilePicButton.layer.cornerRadius = profilePicButton.bounds.height/2
        profilePicButton.layer.masksToBounds = true
        
        addPrescriptionTextView.layer.borderWidth = 1
        addPrescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func getPreviousPrescriptions(){
        guard let customerID = self.patientData?.cUSTOMER_ID else {return}
        APIManager.shared().getPreviousPrescriptions(customerID) {[weak self] (historyResponse, alert) in
            if let response = historyResponse,let pp = response.prescriptions {
                print(pp)
//                self?.prescriptions = pp
                self?.filterData(prescriptions: pp)
            }
        }
    }
    
    
    
    //MARK:- UIAction Buttons
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profilePicAction(_ sender: UIButton) {
    }
    
    func showPicker(){
        docTypePicker = UIPickerView(frame: CGRect(x: 0, y: viewForPicker.frame.height - 200, width: viewForPicker.frame.width, height: 200))
        docTypePicker.backgroundColor = .white
        docTypePicker.delegate = self
        docTypePicker.dataSource = self
        
        toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "kThemeBlue")
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.actionDonePicker(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.actionCancelPicker(_:)))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func actionDonePicker(_ sender:UIButton) {
        view.endEditing(true)
        self.prescriptions[prescriptionIndexToBeUpdated].pLANOFACTION = self.planOfActionValues[docTypePicker.selectedRow(inComponent: 0)]
        if let cell = tableViewPatientDetails.cellForRow(at: IndexPath(row: 1, section: 0)) as? PatientPrescriptionCell {
            cell.prescriptions = self.prescriptions
            cell.tableViewPrescriptions.reloadRows(at: [IndexPath(row: prescriptionIndexToBeUpdated, section: 0)], with: .automatic)
        }
    }
    @objc func actionCancelPicker(_ sender:UIButton) {
        view.endEditing(true)
    }
    
    
    @IBAction func actionAddMedicine(_ sender: UIButton) {
        let vc = MedicineListViewController.instatiate(from: .Appointment)
        vc.delegate = self
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
extension AddMedicationViewController: MedicineListVCDelegate{
    func didSelectMedicines(prescriptions: [PrescriptionModelNew]) {
        self.prescriptions.append(contentsOf: prescriptions)
        self.tableViewPatientDetails.reloadData()
        self.madicationListTableView.reloadData()
    }
    
    
}

extension AddMedicationViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return planOfActionValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return planOfActionValues[row]
    }
    
}

extension AddMedicationViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + self.keys.count //self.previousPrescriptions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientAppointmentDetailsCell") as! PatientAppointmentDetailsCell
            cell.setUpData(patientData: patientData)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientPrescriptionCell") as! PatientPrescriptionCell
        if indexPath.section >= 1 {
            cell.cellType = .history
            if let prescriptions = keyValuePrescriptions[keys[indexPath.section - 1]] {
                cell.configureCellWith(prescriptions: prescriptions)
            }
//            cell.configureCellWith(prescriptions: [self.previousPrescriptions[indexPath.section - 1]])
        }else {
            cell.cellType = .new
            cell.planOfActionPicker = self.docTypePicker
            cell.planOfActionToolbar = self.toolBar
            cell.delegate = self
            cell.configureCellWith(prescriptions: self.prescriptions)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section >= 1 {
            //history
            let prescriptions = keyValuePrescriptions[keys[indexPath.section - 1]] ?? []
            return  CGFloat(128 + (140 * prescriptions.count))
        }
        if indexPath.row == 1 {
            return CGFloat(128 + 44 + (self.prescriptions.count * 140) + 50)
        }
        return UITableView.automaticDimension
    }
    
    private func insertPrescription(withNotes notes: String,complition: @escaping (_ response: Int?)->()){
        guard let appointmentId = self.patientData?.rN_APPOINTMENT_ID else {return}
        guard let currentUserName = UserData.current.firstName else {return}
        SwiftSpinner.show("Submitting Prescription...")
        APIManager.shared().insertPrescription(ofAppointmentId: appointmentId, text: notes, createdBy: currentUserName) { (response, error) in
            if let results = response,let PRESCRIPTION_id = results.first?["PRESCRIPTION_id"] as? Int{
                complition(PRESCRIPTION_id)
            }else {
                SwiftSpinner.hide()
            }
        }
    }
}

extension AddMedicationViewController: PatientPrescriptionDelete{
    
    func openPlanOfActionSheet(for prescriptionIndex: Int) {
        prescriptionIndexToBeUpdated = prescriptionIndex
    }
    
    
    func prescriptionDidSubmit(withNotes: String, prescriptions: [PrescriptionModelNew]) {
        
        if UserData.current.role == "Psychiatrist"{
            self.insertPrescription(withNotes: withNotes) { (PRESCRIPTION_id) in
                SwiftSpinner.hide()
                if PRESCRIPTION_id != nil{
                    Alerts.showAlertViewController(title: "Success!!!", message: "Successfully submitted prescription", btnTitle1: "Ok", ok: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }, viewController: self)
                }
            }
        }else{
            /**************VALIDATION*************/
            var isAllPrescriptionsFilled :(isValid:Bool,errorMessage:String)!
            var errorIndex = -1
            for (index,prescription) in prescriptions.enumerated() {
                isAllPrescriptionsFilled = (prescription.isAllFieldsFilled)
                if !isAllPrescriptionsFilled.0 {
                    errorIndex = index
                    break
                }
            }
            
            if !isAllPrescriptionsFilled.0 && errorIndex != -1{
                Alerts.showAlertViewController(title: "Alert!!!", message: isAllPrescriptionsFilled.1 + "for \(prescriptions[errorIndex].mEDICINE ?? "")", btnTitle1: "Ok", ok: nil, viewController: self)
                return
            }
            
            /**************END OF VALIDATION*************/
            
            self.insertPrescription(withNotes: withNotes) { (PRESCRIPTION_id) in
                if let prescriptionId = PRESCRIPTION_id{
                    self.insertPrescriptionMedicine(prescriptionId: prescriptionId, prescriptions: prescriptions)
                }
            }
        }
    }
    
    
    
    
    func insertPrescriptionMedicine(prescriptionId: Int, prescriptions: [PrescriptionModelNew]){
        guard let currentUserName = UserData.current.firstName else {return}
        let group = DispatchGroup()
        for (_, prescription) in prescriptions.enumerated(){
            group.enter()
            APIManager.shared().insertMedicne(prescriptionId: prescriptionId, medicine: prescription, createdBy: currentUserName) { (response, error) in
                if let _ = error {
                    SwiftSpinner.hide()
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            debugPrint("Submit Prescription Done")
            SwiftSpinner.hide()
            Alerts.showAlertViewController(title: "Success!!!", message: "Successfully submitted prescription", btnTitle1: "Ok", ok: { (action) in
                self.navigationController?.popViewController(animated: true)
            }, viewController: self)
        }
    }
    
}
