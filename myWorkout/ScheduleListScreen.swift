//
//  ScheduleListScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 09/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import CoreData

/*
protocol AddSchedule {
    func didAddSchedule(schedule: Schedule)
}
*/

var schedules : [String] = []

class ScheduleListScreen: UIViewController/*, AddSchedule*/ {

    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadView), name: NSNotification.Name(rawValue: "load"), object: nil)
        getData()   //carica tutti i dati COREDATA al caricamento della schermata
        print(schedules)
        
    }
    
    func loadList(){
        schedules = []
        getData()
        self.TableView.reloadData()
        print(schedules)
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workouts")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            var tmptitle = ""
            for data in result as! [NSManagedObject] {
                if (tmptitle != data.value(forKey: "title") as! String) {
                    schedules.append(data.value(forKey: "title") as! String)
                    tmptitle = data.value(forKey: "title") as! String
                }
                
                /*
                //METODO USATO PER ELIMINARE TUTTI I DATI DA UNA TABELLA
                // Create Fetch Request
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
                
                // Create Batch Delete Request
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                
                do {
                    try context.execute(batchDeleteRequest)
                    
                } catch {
                    // Error Handling
                }
                */
                
            }
        } catch {
            print("errore nel caricamento")
        }
    }
    
    func duration(workoutName: String) -> Int {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Workouts")
        request.returnsObjectsAsFaults = false
        
        var duration = 0
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if (workoutName == (data.value(forKey: "title") as! String)) {
                    duration += (data.value(forKey: "rest") as! Int) * (data.value(forKey: "sets") as! Int)
                    duration += (data.value(forKey: "reps") as! Int) * (data.value(forKey: "sets") as! Int) * 2
                }
            }
        } catch {
            print("errore nel caricamento")
        }
        return duration
    }
    /*
    func didAddSchedule(schedule: Schedule) {
        schedules.append(schedule.title)
        print(schedules)
        TableView.reloadData()
    }
    */
}

/*
extension ScheduleListScreen: ScheduleCellDelegate {
    func didViewSchedule(id: Int) {
        
    }
}
*/


extension ScheduleListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //restituisce il numero di schede
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //restituisce il nome della scheda all' n-esima riga (indexPath.row)
        let schedule = schedules[indexPath.row]
        
        //restituisce la cella
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell") as! ScheduleCell
        
        //setto il titolo della scheda nella cella opportuna
        cell.setSchedule(title: schedule, duration: Int(duration(workoutName: schedule)/60))
//        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indico al navicator controller a quale controller passare dopo la selezione
        let vc = storyboard?.instantiateViewController(withIdentifier: "ScheduleScreen") as? ScheduleScreen
        
        vc?.schedule = schedules[indexPath.row]
        
        //passo da questo viewcontroller al prossimo
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           
            /*let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workouts")
            if let result = try? context.fetch(fetchRequest) {
                for object in result as! [NSManagedObject] {
                    if ((object.value(forKey: "title") as! String) == schedules[indexPath.row]) {
                        context.delete(object)
                        tableView.reloadData()
                        print("eliminato")
                    }
                }
            }*/
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workouts")
            let predicate = NSPredicate(format: "title == %@", schedules[indexPath.row] as CVarArg)
            fetchRequest.predicate = predicate
            let result = try? context.fetch(fetchRequest)
            let resultData = result as! [NSManagedObject]
            
            for object in resultData {
                context.delete(object)
                //schedules.remove(at: indexPath.row)
                //loadList()
                print(schedules)
            }
            schedules.remove(at: indexPath.row)
            
            do {
                try context.save()
                print("saved!")
                //tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .fade)
                //tableView.endUpdates()
                print(schedules)
                
                
            } catch {
                print("Could not save")
            }
            
            loadList()
        }
    }
    
}
