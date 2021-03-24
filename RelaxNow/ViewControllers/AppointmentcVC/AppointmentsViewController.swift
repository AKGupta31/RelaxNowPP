//
//  AppointmentsViewController.swift
//  RelaxNow
//
//  Created by naxtre on 03/03/21.
//

import UIKit

class AppointmentsViewController: UIViewController {

    @IBOutlet weak var tableView_appointments: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView_appointments.register(UINib(nibName: "PatientTableViewCell", bundle: nil), forCellReuseIdentifier: "PatientTableViewCell")

    }


}
extension AppointmentsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatientTableViewCell", for: indexPath) as! PatientTableViewCell
        if indexPath.row %  2 == 0 {
            cell.contentView.backgroundColor = .white
        }
        else
        {

            cell.contentView.backgroundColor = UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)

        }
        
        
        return cell
    }
    
}
