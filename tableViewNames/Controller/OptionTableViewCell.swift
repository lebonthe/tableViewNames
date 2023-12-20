//
//  optionTableViewCell.swift
//  tableViewNames
//
//  Created by Min Hu on 2023/12/20.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var namesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
