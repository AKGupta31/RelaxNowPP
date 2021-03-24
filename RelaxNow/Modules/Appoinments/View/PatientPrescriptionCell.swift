//
//  PatientPrescriptionCell.swift
//  RelaxNow
//
//  Created by Admin on 21/03/21.
//

import UIKit

class PatientPrescriptionCell: UITableViewCell {

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnSearchMedicine: UIButton!
    
    @IBOutlet weak var tableViewPrescriptions: UITableView!
    
    let numberOfCells = 3
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tableViewPrescriptions.dataSource = self
        tableViewPrescriptions.delegate = self
        registerCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        tableViewHeight.constant = CGFloat(140 * numberOfCells)
        self.layoutIfNeeded()
        // Configure the view for the selected state
    }
    
    func registerCell(){
        tableViewPrescriptions.registerTableCell(identifier: .addMedicationTableCell)
    }

}

extension PatientPrescriptionCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.addMedicationTableCell.rawValue, for: indexPath) as? AddMedicationTableCell
//        cell?.configureCell(with: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
}
