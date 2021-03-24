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

    @IBOutlet weak var patientProfilePicImageView: UIImageView!
    @IBOutlet weak var madicationListTableView: UITableView!
    @IBOutlet weak var addPrescriptionTextView: UITextView!
    
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
        patientProfilePicImageView.layer.cornerRadius = patientProfilePicImageView.bounds.height/2
        patientProfilePicImageView.layer.masksToBounds = true
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
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

extension AddMedicationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PatientAppointmentDetailsCell") as! PatientAppointmentDetailsCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientPrescriptionCell") as! PatientPrescriptionCell
        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addMedicationTableCell.rawValue, for: indexPath) as? AddMedicationTableCell
//        cell.setu
//        cell?.configureCell(with: indexPath)
//        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 128 + 44 + 3 * 140
        }
        return UITableView.automaticDimension
    }
    
}
