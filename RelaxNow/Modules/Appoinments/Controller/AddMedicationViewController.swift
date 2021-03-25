//
//  AddMedicationViewController.swift
//  RelaxNow
//
//  Created by Pritrum on 06/03/21.
//

import UIKit

class AddMedicationViewController: UIViewController {
    @IBOutlet weak var tableViewPatientDetails: UITableView!
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePicButton: UIButton!

    @IBOutlet weak var madicationListTableView: UITableView!
    @IBOutlet weak var addPrescriptionTextView: UITextView!
    
    @IBOutlet weak var planOfActionPicker: UIPickerView!
    let planOfActionValues = ["None", "Discontinue", "FIXED","Worsened"]


    @IBOutlet weak var pickerViewBottonConstraint: NSLayoutConstraint!
    private var prescriptions = [PrescriptionModel]()
    var patientData: PatientData?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        tableViewPatientDetails.delegate = self
        tableViewPatientDetails.dataSource = self
//        registerCell()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectAction = planOfActionValues[row]
        debugPrint("selectAction ")
        self.pickerViewBottonConstraint.constant = -200
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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
//        if let prescriptions = self.prescriptions{
            cell.configureCellWith(prescriptions: self.prescriptions)
//        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return CGFloat(128 + 44 + (self.prescriptions.count * 140) + 40)
        }
        return UITableView.automaticDimension
    }
    
    private func insertPrescription(withNotes notes: String,complition: @escaping (_ response: Int?)->()){
        guard let appointmentId = self.patientData?.rN_APPOINTMENT_ID else {return}
        guard let currentUserName = UserData.current.firstName else {return}
        APIManager.shared().insertPrescription(ofAppointmentId: appointmentId, text: notes, createdBy: currentUserName) { (response, error) in
            if let results = response,let PRESCRIPTION_id = results.first?["PRESCRIPTION_id"] as? Int{
                complition(PRESCRIPTION_id)
            }
            debugPrint(error, response)
        }
    }
    
    
}

extension AddMedicationViewController: PatientPrescriptionDelete{
    func didSelectPlanOfAction(prescriptionData: PrescriptionModel, button: UIButton) -> String {
        //Open Picker View
        self.pickerViewBottonConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        return "None"
    }

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
                debugPrint("response ",response)
                debugPrint("error ",error)
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            debugPrint("Submit Prescription Done")
        }
    }
    
}
