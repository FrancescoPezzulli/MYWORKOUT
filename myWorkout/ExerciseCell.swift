//
//  ExerciseCell.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 10/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {
    
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    @IBOutlet weak var primaryMuscleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame.size.width = UIScreen.main.bounds.width
        layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.90
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space
            
            super.frame = frame
            
        }
    }
    */
    
    func setExercise(title: String, primaryMuscle: String) {
        exerciseTitleLabel.text = title
        primaryMuscleLabel.text = primaryMuscle
    }

}
