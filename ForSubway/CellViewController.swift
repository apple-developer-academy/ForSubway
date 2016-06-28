//
//  CellViewController.swift
//  ForSubway
//
//  Created by Gabriel Cavalcante on 27/06/16.
//  Copyright © 2016 Gabriel Cavalcante. All rights reserved.
//

import UIKit

class CellViewController: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelArrivalTime: UILabel!
    
    @IBOutlet weak var labelDepartureTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}