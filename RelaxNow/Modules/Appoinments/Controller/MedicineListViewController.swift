//
//  MedicineListViewController.swift
//  RelaxNow
//
//  Created by Admin on 20/03/21.
//

import UIKit



protocol MedicineListVCDelegate:class {
    func didSelectMedicines(prescriptions:[PrescriptionModel])
}

class MedicineListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewMedicines: UITableView!
    var originalMedicines = [MedicineModel]()
    var searchedMedicines = [MedicineModel]()
    weak var delegate:MedicineListVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        getMedicines()
        
        searchBar.compatibleSearchTextField.textColor = UIColor.black
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        searchBar.layer.borderWidth = 1.0
        searchBar.layer.borderColor =  (UIColor(named: "BorderColor") ?? .darkGray).cgColor
        // Do any additional setup after loading the view.
    }
    
    
    private func getMedicines(){
      
        APIManager.shared().getListOfMedicines {[weak self] (medicineResponse, alertMessage) in
            if let medicines = medicineResponse?.medicines {
                self?.originalMedicines = medicines
                self?.searchedMedicines = medicines
                self?.tableViewMedicines.reloadData()
            }else {
                //show alert
            }
        }
    }
    
    @IBAction func actionDone(_ sender: UIButton) {
        let selectedMedicines = self.searchedMedicines.filter({$0.isSelected})
        delegate?.didSelectMedicines(prescriptions:PrescriptionModel.getPrescriptions(medicines: selectedMedicines))
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension MedicineListViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedMedicines.removeAll()
        if searchText.isEmpty {
            self.searchedMedicines = self.originalMedicines
        }else {
            for medicine in originalMedicines {
                if medicine.name?.localizedCaseInsensitiveContains(searchText) ?? false{
                    searchedMedicines.append(medicine)
                }
            }
        }
       
        self.tableViewMedicines.reloadData()
    }
}

extension MedicineListViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedMedicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineSelectionCell") as! MedicineSelectionCell
        let medicine = self.searchedMedicines[indexPath.row]
        cell.lblMedicineName.text = medicine.name
        cell.btnSelectedImage.isSelected = medicine.isSelected
        cell.viewContent.backgroundColor =  indexPath.row % 2 == 0 ? UIColor(named: "BackgroundGrayColor") : .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchedMedicines[indexPath.row].isSelected = !searchedMedicines[indexPath.row].isSelected
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}




