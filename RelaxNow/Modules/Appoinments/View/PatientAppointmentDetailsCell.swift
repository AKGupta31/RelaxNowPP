//
//  PatientAppointmentDetailsCell.swift
//  RelaxNow
//
//  Created by Admin on 21/03/21.
//

import UIKit

class PatientAppointmentDetailsCell: UITableViewCell {

    @IBOutlet weak var patientProfilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var phoneNumberButton: UIButton!
    @IBOutlet weak var reportsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        patientProfilePicImageView.layer.cornerRadius = patientProfilePicImageView.bounds.height/2
        patientProfilePicImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func setUpData(patientData: PatientData?){
       
        if let firstName = patientData?.rN_CUSTOMER_FIRST_NAME{
            self.nameLabel.text = firstName
        }
        
        if let date = patientData?.aPPOINTMENT_DATE{
            self.dateLabel.text = date
        }
        
        if let rnNumber = patientData?.rELATIONSHIP_NUMBER {
            self.addressLabel.text = rnNumber
        }
//        if let address = patientData?.rN_CUSTOMER_ADDRESS{
////            self.addressLabel.text = address
//        }
        
        if let email = patientData?.rN_CUSTOMER_EMAIL{
            self.emailButton.setTitle(email, for: .normal)
        }
        if let mobileNumber = patientData?.rN_CUSTOMER_MOBILE{
            self.phoneNumberButton.setTitle(mobileNumber, for: .normal)
        }
        
    }
    
}
