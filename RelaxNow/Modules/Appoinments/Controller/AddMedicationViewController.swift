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
    private var prescriptions = [PrescriptionModel]()
    var patientData: PatientData?
    var docTypePicker: UIPickerView!
    var toolBar:UIToolbar!
    
    var prescriptionIndexToBeUpdated = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        tableViewPatientDetails.delegate = self
        tableViewPatientDetails.dataSource = self
        showPicker()
        viewForPicker.isHidden = true
    }
    
    
    
    //MARK:- Helper Methods

    private func setUpUI(){
        profilePicButton.layer.cornerRadius = profilePicButton.bounds.height/2
        profilePicButton.layer.masksToBounds = true
       
        addPrescriptionTextView.layer.borderWidth = 1
        addPrescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
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
        self.prescriptions[prescriptionIndexToBeUpdated].action = self.planOfActionValues[docTypePicker.selectedRow(inComponent: 0)]
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
    func didSelectMedicines(prescriptions: [PrescriptionModel]) {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientAppointmentDetailsCell") as! PatientAppointmentDetailsCell
            cell.setUpData(patientData: patientData)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientPrescriptionCell") as! PatientPrescriptionCell
            cell.configureCellWith(prescriptions: self.prescriptions)
        cell.planOfActionPicker = self.docTypePicker
        cell.planOfActionToolbar = self.toolBar
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
    
//    func didSelectPlanOfAction(prescriptionData: PrescriptionModel, button: UIButton) -> String {
//        //Open Picker View
////        self.pickerViewBottonConstraint.constant = 0
////        UIView.animate(withDuration: 0.3) {
////            self.view.layoutIfNeeded()
////        }
////        return "None"
//    }
    
    

    func prescriptionDidSubmit(withNotes: String, prescriptions: [PrescriptionModel]) {
        self.insertPrescription(withNotes: withNotes) { (PRESCRIPTION_id) in
            if let prescriptionId = PRESCRIPTION_id{
                self.insertPrescriptionMedicine(prescriptionId: prescriptionId, prescriptions: prescriptions)
            }
        }
    }
    
    
    func insertPrescriptionMedicine(prescriptionId: Int, prescriptions: [PrescriptionModel]){
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
        }
    }
    
}
