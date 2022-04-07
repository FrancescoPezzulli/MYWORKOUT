//
//  WorkoutCell.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 13/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {

    @IBOutlet weak var imageExercise: UIImageView!
    @IBOutlet weak var labelExercise: UILabel!
    @IBOutlet weak var buttonSetsReps: UIButton!
    @IBOutlet weak var labelRest: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame.size.width = UIScreen.main.bounds.width
        layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setWorkoutCell(image: UIImage, exerciseTitle: String, sets: Int, reps: Int, rest: Int) {
        imageExercise.image = image
        labelExercise.text = exerciseTitle
        let sets = String(sets)
        let reps = String(reps)
        let setsNReps = sets + "X" + reps
        buttonSetsReps.setTitle(setsNReps, for: .normal)
        buttonSetsReps.layer.cornerRadius = 20
        labelRest.text = String(rest) + "\""
    }
    @IBAction func buttonWeightOnClick(_ sender: Any) {
        
    }
    
}
