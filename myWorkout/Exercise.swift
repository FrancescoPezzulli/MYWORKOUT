//
//  Exercise.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 10/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

class Exercise {
    var name: String
    var primaryMuscle: String
    var image : UIImage
    var description: String
    var weights: [Float] = []
    var dates: [Date] = []
    
    init(name:String, description:String, image:UIImage, primaryMuscle:String) {
        self.name = name
        self.primaryMuscle = primaryMuscle
        self.image = image
        self.description = description
        weights.append(0.0)
        dates.append(Date())
    }
    
    func getLastWeight() -> Float {
        return weights[weights.count-1]
    }
    
    func getLastDate() -> Date {
        return dates[dates.count-1]
    }
    
    func getImage() -> UIImage {
        return image
    }
}
