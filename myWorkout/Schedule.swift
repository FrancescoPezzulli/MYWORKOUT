//
//  Schedule.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 10/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

struct CustomEx {
    var exercise: String
    var sets: Int
    var reps: Int
    var rest: Int
    var pos: Int
}

class Schedule {
    var title : String
    var exercises: [CustomEx]

    init(title: String, exercises: [CustomEx]) {
        self.title = title
        self.exercises = exercises
    }

    
    

}
