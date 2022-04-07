//
//  NewScheduleCell.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 31/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

class NewScheduleCell: UITableViewCell {
    
    @IBOutlet weak var labelExercise: UILabel!
    @IBOutlet weak var buttonSetsReps: UIButton!
    @IBOutlet weak var labelRest: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonSetsReps.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
