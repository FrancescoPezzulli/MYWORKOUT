//
//  NewScheduleScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 31/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import CoreData

protocol AddRowDelegate {
    func didAddRow(exercise:String, sets:String, reps:String, rest:String)
}

var workout : [Schedule] = []
var exercisesOfWorkout : [CustomEx] = []
var counter = 1


class NewScheduleScreen: UIViewController, UIAlertViewDelegate , AddRowDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var aggiungiButton: UIButton!
    @IBOutlet weak var fineButton: UIButton!
    
    func didAddRow(exercise: String, sets: String, reps: String, rest: String) {
        //aggiungo i dati all'array degli esercizi
        exercisesOfWorkout.append(CustomEx(exercise: exercise, sets: Int(sets)!, reps: Int(reps)!, rest: Int(rest)!, pos: counter))
        counter += 1
        //aggiorna i dati della tableview
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aggiungiButton.layer.cornerRadius = 10
        fineButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func addExercise(_ sender: Any) {
        //mostra la finestra modal PopUpAddExercise
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpAddExercise") as? PopUpAddExercise
        vc?.modalTransitionStyle = .crossDissolve
        vc?.delegate = self
        self.present(vc!, animated: true, completion: nil)
    }
    
    //salva la nuova scheda di allenamento
    @IBAction func done(_ sender: Any) {
        if (exercisesOfWorkout.count > 0 && nameTextField.text != "") {
            //posso salvare il nuovo allenamento
            let newSchedule = Schedule(title: nameTextField.text!, exercises: exercisesOfWorkout)
            workout.append(newSchedule)
            schedules.append(newSchedule.title)
            print(schedules)
            saveData(schedule: newSchedule)
            
            //segnale a ScheduleListScreen per l'aggiornamento della table
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            let alert = UIAlertController(title: "Scheda aggiunta", message: "La scheda è stata ora aggiunta alla sezione degli allenamenti, corri ad allenarti!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            exercisesOfWorkout = []
            tableView.reloadData()
            nameTextField.text = ""
            counter = 1
            
        } else {
            //errore
            let alert = UIAlertController(title: "Scheda errata", message: "Non è stato possibile aggiungere la scheda perchè non risulta essere compilata correttamente, riprova", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func saveData(schedule: Schedule) {
        
        //SALVATAGGIO SU WORKOUTS
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entityWorkout = NSEntityDescription.entity(forEntityName: "Workouts", in: context)
        
        for ex in exercisesOfWorkout {
            let tmpEntity = NSManagedObject(entity: entityWorkout!, insertInto: context)
            tmpEntity.setValue(schedule.title, forKey: "title")
            tmpEntity.setValue(ex.exercise, forKey: "exercise")
            tmpEntity.setValue(ex.sets, forKey: "sets")
            tmpEntity.setValue(ex.reps, forKey: "reps")
            tmpEntity.setValue(ex.rest, forKey: "rest")
            tmpEntity.setValue(ex.pos, forKey: "pos")
        }
        
        do {
            try context.save()
            //schedules.append(schedule.title)
            print("salvato")
            print(exercisesOfWorkout)
        } catch {
            print("errore nel salvataggio")
        }
    }
    
}

extension NewScheduleScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesOfWorkout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewScheduleCell") as! NewScheduleCell
        cell.labelExercise.text = exercisesOfWorkout[indexPath.row].exercise
        cell.buttonSetsReps.setTitle(String(exercisesOfWorkout[indexPath.row].sets) + "X" + String(exercisesOfWorkout[indexPath.row].reps), for: .normal)
        cell.labelRest.text = String(exercisesOfWorkout[indexPath.row].rest) + "\""
        return cell
    }
    

}
