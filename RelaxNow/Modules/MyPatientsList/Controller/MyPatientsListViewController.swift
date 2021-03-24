//
//  MyPatientsListViewController.swift
//  RelaxNow
//
//  Created by Pritrum on 06/03/21.
//

import UIKit

class MyPatientsListViewController: UIViewController {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePicButton: UIButton!
    
    @IBOutlet weak var currentDateButton: UIButton!
    @IBOutlet weak var appointmentCount: UILabel!
    @IBOutlet weak var appointmentLabel: UILabel!
    @IBOutlet weak var departmentPicImageView: UIImageView!
    
    @IBOutlet weak var patientSearchBar: UISearchBar!
    @IBOutlet weak var appointmentListTableView: UITableView!

//    var patients = [PatientData]()
    var patientsVM:AppointmentViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setUpUI()

        if patientsVM == nil{
            getListOfPatients()
        }else{
            setUpData()
        }
//        getListOfPatients()
//        setUpUI()
//        setUpData()
        
    }
    
    // MARK:- Helper Methods 
    private func setUpUI(){
        profilePicButton.layer.cornerRadius = profilePicButton.bounds.height/2
        profilePicButton.layer.masksToBounds = true
        departmentPicImageView.layer.cornerRadius = departmentPicImageView.bounds.height/2
        departmentPicImageView.layer.masksToBounds = true

    }
    
    private func setUpData(){
//        appointmentCount.text = "\(self.patients.count)"
        appointmentCount.text = "\(patientsVM!.numberOfItems)"

    }
    
    func registerCell(){
        appointmentListTableView.registerTableCell(identifier: .patientTableViewCell)
    }

    @IBAction func menuAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sideMenuButtonAction(_ sender: UIButton) {
       
        guard let sideMenuController = sideMenuController else { return }
        sideMenuController.showLeftView(animated: true, completion: nil)
    }
    @IBAction func profilePicAction(_ sender: UIButton) {
        let controller = AddMedicationViewController.instatiate(from: .Appointment)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
 
    private func getListOfPatients(){


        APIManager.shared().listOfPatientss("1235", "2021-03-08") { [weak self] (patients, alert) in
            if let patients = patients{
                self?.patientsVM = AppointmentViewModel()
                self?.patientsVM?.setAppointmentList(appointments: patients)
//                    .append(contentsOf: patients)
                Helper.dispatchMain {
                    self?.setUpData()
                    self?.appointmentListTableView.reloadData()
                }
            }else{
                debugPrint("Show Alert", alert?.body)
            }
        }
    }

}

extension MyPatientsListViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        debugPrint("search bar begin editing")

        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        debugPrint("cancel button clicked")
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        searchBar.text = ""
        patientsVM?.resetSearchResult()
        self.appointmentListTableView.reloadData()
        // rese result
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        debugPrint("search bar end editing")
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            debugPrint("reset search result")
            patientsVM?.resetSearchResult()
        }else{
            // filter result from array
            patientsVM?.filterResultWith(text: searchText)
        }
        self.appointmentListTableView.reloadData()
        debugPrint("Search bar text did change")
    }
}


extension MyPatientsListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientsVM?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.patientTableViewCell.rawValue, for: indexPath) as? PatientTableViewCell
        if let appointment = patientsVM?.appointment(atIndex: indexPath.item){
            cell?.configureMyPatientCell(with: appointment, atIndexPath: indexPath)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
