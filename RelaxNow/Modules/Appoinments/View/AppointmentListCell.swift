//
//  AppointmentListCell.swift
//  RelaxNow
//
//  Created by Pritrum on 03/03/21.
//

import UIKit

class AppointmentListCell: UITableViewCell {

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var timeDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        profilePicImageView.layer.cornerRadius =  profilePicImageView.bounds.height/2
//        profilePicImageView.layer.masksToBounds = true
        Utility.sharedInstance.setCornerRaduis(cornerRadius:profilePicImageView.frame.size.width/2.0,view:profilePicImageView)
//        Utility.sharedInstance.setShadow(shadowOffset: CGSize(width: 1, height: 1), shadowColor: .lightGray, view: profilePicImageView, shadowRadius: 1, shadowOpacity: 1)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func appointmentForPatient(with indexPath: IndexPath){
        bgView.backgroundColor = (indexPath.row % 2 == 0) ? .white : .lightGray

    }
    
    
    
}
