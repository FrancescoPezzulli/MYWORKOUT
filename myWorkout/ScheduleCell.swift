//
//  ScheduleCell.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 09/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

/*
protocol ScheduleCellDelegate {
    func didViewSchedule(id: Int)
}
*/

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var labelSchedule: UILabel!
    @IBOutlet weak var imageNext: UIImageView!
    @IBOutlet weak var labelDuration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame.size.width = UIScreen.main.bounds.width
        layoutIfNeeded()
    }
    
    func setSchedule(title: String, duration: Int) {
        labelSchedule.text = title
        labelDuration.text = String("durata = " + String(duration) + " minuti")
        
    }

/*
    @IBAction func viewSchedule(_ sender: Any) {
        delegate?.didViewSchedule(id: buttonSchedule.tag)
    }
*/
    
}
