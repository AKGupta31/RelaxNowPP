//
//  MedicineSelectionCell.swift
//  RelaxNow
//
//  Created by Admin on 20/03/21.
//

import UIKit

class MedicineSelectionCell: UITableViewCell {
    @IBOutlet weak var lblMedicineName: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var btnSelectedImage: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
