//
//  DashboardViewController.swift
//  RelaxNow
//
//  Created by naxtre on 03/03/21.
//

import UIKit
import LGSideMenuController
class DashboardViewController: UIViewController {
    @IBOutlet weak var lblAppointmentsCount: UILabel!
    @IBOutlet weak var lblTodayPatientCount: UILabel!
    @IBOutlet weak var lblToalPatientCount: UILabel!
    @IBOutlet var tableview_patient: UITableView!
    
    @IBOutlet weak var profileButton: UIButton!
//    private var patients = [PatientData]()
    var appointmentVM = AppointmentViewModel()
    var patientsVM = AppointmentViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview_patient.register(UINib(nibName: "PatientTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientTableViewCell")
        getListOfAppointments()
        getListOfPatients()
        setupUI()
    }
    
    private func setupUI(){
        Utility.sharedInstance.setRoundCorner(view: profileButton)
    }
    
    @IBAction func actionSeeTotalPatients(_ sender: UIButton) {
        if self.patientsVM.numberOfItems > 0 {
            let controller = MyPatientsListViewController.instatiate(from: .Appointment)
            controller.patientsVM = self.patientsVM
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    @IBAction func actionSeeTodayPatients(_ sender: UIButton) {
        let controller = MyPatientsListViewController.instatiate(from: .Appointment)
        controller.patientsVM = self.patientsVM
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionSeeAllAppointments(_ sender: UIButton) {
       
        if appointmentVM.numberOfItems > 0 {
            let controller = AppointmentListViewController.instatiate(from: .Appointment)
            controller.appointmentVM = self.appointmentVM
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    @IBAction func sideMenuButtonAction(_ sender: UIButton) {
        guard let sideMenuController = sideMenuController else { return }
        sideMenuController.showLeftView(animated: true, completion: nil)
    }
}

//MARK: API Service

extension DashboardViewController {
    private func getListOfPatients(){
        guard let id = UserData.current.userId else {return}
        APIManager.shared().listOfPatientss(String(id), "1900-01-01") { [weak self] (patients, alert) in
            if let patients = patients{
                self?.patientsVM.setAppointmentList(appointments: patients)
//                self?.patients.append(contentsOf: patients)
                self?.lblToalPatientCount.text = self?.patientsVM.numberOfItems.description
                self?.lblTodayPatientCount.text = self?.patientsVM.numberOfItems.description
            }else{
                //                debugPrint("Show Alert", alert?.body)
            }
        }
    }
    
    
    private func getListOfAppointments(){
        guard let id = UserData.current.userId else {return}
        APIManager.shared().listOfAppointments(String(id), "1900-01-01") { [weak self] (patients, alert) in
            if let appointments = patients{
                self?.appointmentVM.setAppointmentList(appointments: appointments)
                self?.lblAppointmentsCount.text = self!.appointmentVM.numberOfItems.description
                Helper.dispatchMain {
                    self?.tableview_patient.reloadData()
                }
            }else{
                //                debugPrint("Show Alert", alert?.body)
            }
        }
    }
}
extension DashboardViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentVM.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell", for: indexPath) as! PatientTableViewCell
        if let appointment = appointmentVM.appointment(atIndex: indexPath.item){
            cell.configureMyPatientCell(with: appointment, atIndexPath: indexPath)
        }
//        cell.configureMyPatientCell(with: patients[indexPath.row], atIndexPath: indexPath)
        if indexPath.row %  2 == 0 {
            cell.contentView.backgroundColor = .white
        }
        else
        {
            cell.contentView.backgroundColor = UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let patientData = appointmentVM.appointment(atIndex: indexPath.item)
        let controller = AddMedicationViewController.instatiate(from: .Appointment)
        controller.patientData = patientData
        self.navigationController?.pushViewController(controller, animated: true)
    }
   
}
