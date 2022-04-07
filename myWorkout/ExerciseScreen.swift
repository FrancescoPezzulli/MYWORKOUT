//
//  ExerciseScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 26/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

class ExerciseScreen: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var exercise = Exercise(name: "", description: "", image: #imageLiteral(resourceName: "benchpress"), primaryMuscle: "")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = exercise.name
        exerciseImage.image = exercise.image
        descriptionTextView.text = exercise.description
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
