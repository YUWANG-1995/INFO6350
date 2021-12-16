//
//  CityCard.swift
//  FinalProject-WeatherApp
//
//  Created by Yu Wang on 2021/12/15.
//

import UIKit

class CityCard: UITableViewCell {

    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var ConditaionLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
