//
//  ScheduleScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 11/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import CoreData

class ScheduleScreen: UIViewController {
    
    var workout : Schedule = Schedule(title: "", exercises: [])
    
    //NOME DELL'ALLENAMENTO PASSATO DA SCHEDULELISTSCREEN
    var schedule = ""
    
    @IBOutlet weak var buttonStartWorkout: UIBarButtonItem!
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = schedule
        workout.title = schedule
        getData()
        self.navigationController?.isToolbarHidden = false
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workouts")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if ((data.value(forKey: "title") as! String) == schedule) {
                    workout.exercises.append(CustomEx(exercise: (data.value(forKey: "exercise") as! String), sets: (data.value(forKey: "sets") as! Int), reps: (data.value(forKey: "reps") as! Int), rest: (data.value(forKey: "rest") as! Int), pos: (data.value(forKey: "pos") as! Int)))
                }
            }
            //ordino l'array
            var arraysorted : [CustomEx] = workout.exercises
            arraysorted = arraysorted.sorted(by: { $0.pos < $1.pos })
            workout.exercises = arraysorted
            print(workout.exercises)
            
        } catch {
            print("errore nel caricamento della scheda")
        }
    }
    
    func getExerciseImage(exercise: String) -> UIImage {
        var res : UIImage = UIImage()
        for tmp in exercises {
            if(tmp.name == exercise) {
                res = tmp.image
            }
        }
        return res
    }
    
    //fa scomparire il bottone della toolbar AVVIA ALLENAMENTO quando si fa BACK
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if self.isMovingFromParent {
            self.navigationController?.isToolbarHidden = true;
        }
        if self.isBeingDismissed{
            //
        }
    }
    
    @IBAction func showLiveWorkout(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LiveWorkoutScreen") as? LiveWorkoutScreen
        vc?.workout = workout
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}


extension ScheduleScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell") as! WorkoutCell
        cell.setWorkoutCell(image: getExerciseImage(exercise: workout.exercises[indexPath.row].exercise), exerciseTitle: workout.exercises[indexPath.row].exercise, sets: workout.exercises[indexPath.row].sets, reps: workout.exercises[indexPath.row].reps, rest: workout.exercises[indexPath.row].rest)
        return cell
    }
}
