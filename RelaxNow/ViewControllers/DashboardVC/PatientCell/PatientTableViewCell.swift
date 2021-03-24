//
//  PatientTableViewCell.swift
//  RelaxNow
//
//  Created by naxtre on 03/03/21.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    @IBOutlet weak var imageView_user: ZWView!
    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        Utility.sharedInstance.setCornerRaduis(cornerRadius:imageView_user.frame.size.width/2.0,view:imageView_user)
      
//        imageView_user.addShadowOnAllSides()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureMyPatientCell(with patient: PatientData, atIndexPath indexPath: IndexPath){
        bgView.backgroundColor = (indexPath.row % 2 == 0) ? .white : .lightGray
        if let firstName = patient.rN_CUSTOMER_FIRST_NAME{
            self.nameLabel.text = firstName
        }
        
        if let date = patient.aPPOINTMENT_DATE{
            self.dateLabel.text = date
        }
        
        if let address = patient.rN_CUSTOMER_ADDRESS{
            self.addressLabel.text = address
        }
        
//        let radius = imageView_user.frame.size.width/2.0
//        imageView_user.addShadow(offset: CGSize(width: 0, height: 0), radius: 3, color: .black, opacity: 1, cornerRadius: radius)
//        imageView_user.round = true
    
    }
}
