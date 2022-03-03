//
//  CustomCell.swift
//  TransportApp
//
//  Created by Никита Макаревич on 28.02.2022.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var transportView: UIView!
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var typeLable: UILabel!
    @IBOutlet weak var timeArrivalLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
