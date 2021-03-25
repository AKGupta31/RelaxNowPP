//
//  AppoinmentListViewController.swift
//  RelaxNow
//
//  Created by Pritrum on 03/03/21.
//

import UIKit

class AppointmentListViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePicButton: UIButton!
    
    
    @IBOutlet weak var currentDateButton: UIButton!
    @IBOutlet weak var appointmentCount: UILabel!
    @IBOutlet weak var appointmentLabel: UILabel!
    @IBOutlet weak var departmentPicImageView: UIImageView!
    
    @IBOutlet weak var patientSearchBar: UISearchBar!
    
    @IBOutlet weak var upcomingButton: UIButton!
    @IBOutlet weak var todayButton: UIButton!
    
    @IBOutlet weak var appointmentListTableView: UITableView!
    
    var appointmentVM:AppointmentViewModel?// = AppointmentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
//        self.getListOfAppointments()
//        setUpUI()
//        setUpData()
        setUpUI()
        if appointmentVM == nil{
            getListOfAppointments()
        }else{
            setUpData()
        }
        
        appointmentVM?.reloadData = {[weak self] in
            self?.appointmentListTableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    private func setUpUI(){
        profilePicButton.layer.cornerRadius = profilePicButton.bounds.height/2
        profilePicButton.layer.masksToBounds = true
        
        departmentPicImageView.layer.cornerRadius = departmentPicImageView.bounds.height/2
        departmentPicImageView.layer.masksToBounds = true
        
        upcomingAndTodayAppoinmentAction(upcomingButton)
        patientSearchBar.compatibleSearchTextField.textColor = UIColor.black
        patientSearchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        patientSearchBar.layer.borderWidth = 1.0
        patientSearchBar.layer.borderColor =  (UIColor(named: "BorderColor") ?? .darkGray).cgColor
    }
    
    private func setUpData(){
        appointmentCount.text = "\(appointmentVM!.numberOfItems)"
    }
    //MARK:- Helper Methods
    func registerCell(){
        appointmentListTableView.registerTableCell(identifier: .patientTableViewCell)
    }
    
    //MARK:- UIAction Buttons
    
    @IBAction func menuAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profilePicAction(_ sender: UIButton) {
        let controller = MyPatientsListViewController.instatiate(from: .Appointment)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func upcomingAndTodayAppoinmentAction(_ sender: UIButton) {
        switch sender.tag {
        case 1: // Upcoming
            upcomingButton.backgroundColor = .lightGreen
            todayButton.backgroundColor = .clear
            todayButton.layer.borderWidth = 1
            todayButton.layer.borderColor = UIColor.lightGreen.cgColor
            todayButton.setTitleColor(.lightGreen, for: .normal)
            upcomingButton.setTitleColor(.white, for: .normal)
            appointmentVM?.selectedTab = .upcoming
        default: //Today
            todayButton.backgroundColor = .lightGreen
            upcomingButton.backgroundColor = .clear
            upcomingButton.layer.borderWidth = 1
            upcomingButton.layer.borderColor = UIColor.lightGreen.cgColor
            todayButton.setTitleColor(.white, for: .normal)
            upcomingButton.setTitleColor(.lightGreen, for: .normal)
            appointmentVM?.selectedTab = .today
            
            break
        }
    }
    @IBAction func sideMenuButtonAction(_ sender: UIButton) {
       
        guard let sideMenuController = sideMenuController else { return }
        sideMenuController.showLeftView(animated: true, completion: nil)
    }
}

extension AppointmentListViewController: UISearchBarDelegate{
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
        appointmentVM?.resetSearchResult()
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
            appointmentVM?.resetSearchResult()
        }else{
            // filter result from array
            appointmentVM?.filterResultWith(text: searchText)
        }
        self.appointmentListTableView.reloadData()
        debugPrint("Search bar text did change")
    }
}

extension AppointmentListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentVM?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.patientTableViewCell.rawValue, for: indexPath) as? PatientTableViewCell
        if let appointment = appointmentVM?.appointment(atIndex: indexPath.item){
            cell?.configureMyPatientCell(with: appointment, atIndexPath: indexPath)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    private func getListOfAppointments(){
        guard let id = UserData.current.userId else {return}
        APIManager.shared().listOfAppointments(String(id), "1900-01-01") { [weak self] (patients, alert) in
            if let appointments = patients{
                self?.appointmentVM = AppointmentViewModel()
                self?.appointmentVM?.viewType = .appointmentScreen
                self?.appointmentVM?.setAppointmentList(appointments: appointments)
                Helper.dispatchMain {
                    self?.setUpData()
                    self?.appointmentListTableView.reloadData()
                }
            }else{
                //                debugPrint("Show Alert", alert?.body)
            }
        }
    }
}
/*func listOfAppointments(_ doctorId: String,_ date: String, complition: @escaping (_ patients: [PatientData]?, _ message: AlertMessage?)->()){
 let parameter:Parameters = ["query":"\(EndpointItem.doctorAppointments.path)('\(doctorId)','\(date)')",
                             "params":""]
 self.callMethod(type: .loginByMobile, params: parameter) { (appointment: PatientBaseData?, alert) in
     complition(appointment?.patients,alert)
 }
}
*/
