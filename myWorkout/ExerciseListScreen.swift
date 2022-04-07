//
//  ExerciseListScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 10/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import CoreData

var exercises : [Exercise] = [
    Exercise(
        name: "Croci con manubri su panca piana",
        description: "Si aprono le braccia tenendo i gomiti leggermente flessi. La presa è neutra; i palmi saranno quindi rivolti verso l'alto quando avremo divaricato completamente le braccia. Durante il movimento l'unica articolazione che si muove è quella della spalla. Poi le braccia si richiudono evitando però di ritornare nella posizione iniziale con le braccia perpendicolari al suolo, perché in tale condizione la tensione sui pettorali si annulla, per cui è necessario fermarsi un po' prima.",
        image: #imageLiteral(resourceName: "croci-con-manubri-su-panca-piana.jpg"),
        primaryMuscle: "Pettorale"),
    Exercise(
        name: "Distensioni con manubri su panca piana",
        description: "Si sollevano i manubri verso l'alto mantenendoli sempre paralleli al suolo senza muovere altre parti del corpo. Quando avremo i gomiti completamente distesi, i manubri si saranno avvicinati fin quasi a toccarsi e la tensione sui pettorali sarà molto bassa. Per questo non bisogna indugiare in tale posizione e con un movimento fluido si continuano le ripetizioni. Durante la discesa dei manubri dobbiamo sentire uno stiramento ai pettorali e per questo i gomiti devono andare sufficientemente indietro da consentire alle scapole di avvicinarsi. Se non si sente lo stiramento del gran pettorale e non si riesce ad addurre le scapole, probabilmente la distanza fra le mani è troppo ampia o c'è qualche altro difetto posturale da correggere. Se non ci si concentra sull'adduzione delle scapole, alla lunga un'esecuzione incompleta dell'esercizio può causare una cifosi dorsale ovvero spalle in avanti e dorso curvo. Pertanto dopo questo esercizio è opportuno eseguire esercizi di compenso che comportino l'avvicinamento delle scapole come molti esercizi per i dorsali tra cui il rematore.",
        image: #imageLiteral(resourceName: "distensioni-con-manubri-su-panca-piana.jpg"),
        primaryMuscle: "Pettorale"),
    Exercise(
        name: "Distensioni con bilanciere su panca piana declinata",
        description: "Si porta il bilanciere verso il basso fino a sfiorare il torace, quindi dopo qualche istante di tensione si spinge il peso verso l'alto senza muovere altre parti del corpo. Quando avremo i gomiti completamente distesi, la tensione sui pettorali sarà molto bassa, per cui non bisogna indugiare in tale posizione e con un movimento fluido si continuano le ripetizioni. Durante la discesa del bilanciere dobbiamo sentire uno stiramento ai pettorali e per questo i gomiti devono andare sufficientemente indietro da consentire alle scapole di avvicinarsi. Se non si sente lo stiramento del gran pettorale e non si riesce ad addurre le scapole, probabilmente la distanza fra le mani è troppo ampia o c'è qualche altro difetto posturale da correggere. Se non ci si concentra sull'adduzione delle scapole, alla lunga un'esecuzione incompleta dell'esercizio può causare una cifosi dorsale ovvero spalle in avanti e dorso curvo. Pertanto dopo questo esercizio è opportuno eseguire esercizi di compenso che comportino l'avvicinamento delle scapole come molti esercizi per i dorsali tra cui il rematore.",
        image: #imageLiteral(resourceName: "distensioni-con-bilanciere-su-panca-piana-declinata.jpg"),
        primaryMuscle: "Pettorale"),
    Exercise(
        name: "Distensioni con bilanciere su panca inclinata",
        description: "Si porta il bilanciere verso il basso fino a sfiorare il torace, quindi dopo qualche istante di tensione si spinge il peso verso l'alto senza muovere altre parti del corpo. Quando avremo i gomiti completamente distesi, la tensione sui pettorali sarà molto bassa, per cui non bisogna indugiare in tale posizione e con un movimento fluido si continuano le ripetizioni. Durante la discesa del bilanciere dobbiamo sentire uno stiramento ai pettorali e per questo i gomiti devono andare sufficientemente indietro da consentire alle scapole di avvicinarsi. Se non si sente lo stiramento del gran pettorale e non si riesce ad addurre le scapole, probabilmente la distanza fra le mani è troppo ampia o c'è qualche altro difetto posturale da correggere. Se non ci si concentra sull'adduzione delle scapole, alla lunga un'esecuzione incompleta dell'esercizio può causare una cifosi dorsale ovvero spalle in avanti e dorso curvo. Pertanto dopo questo esercizio è opportuno eseguire esercizi di compenso che comportino l'avvicinamento delle scapole come molti esercizi per i dorsali tra cui il rematore.",
        image: #imageLiteral(resourceName: "distensioni-con-bilanciere-su-panca-inclinata.jpg"),
        primaryMuscle: "Pettorale")]

class ExerciseListScreen: UIViewController {
    
    @IBOutlet weak var ExercisesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //deleteAllRecords()
        for ex in exercises {
            saveNewExercise(exercise: ex)
        }
        /*
        let url = "../data/exercises.json"
        let urlObj = URL(string:url)
        URLSession.shared.dataTask(with: urlObj!) {(data, response, error) in
            do {
                self.exercises = try JSONDecoder().decode([Exercise].self, from: data!)
            } catch {
                print("error in formatting json exercises")
            }
        }.resume()
        */
    }
    
    func saveNewExercise(exercise: Exercise) {
        //CONTROLLO CHE L'ESERCIZIO NON SIA GIA' PRESENTE
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercises")
        request.returnsObjectsAsFaults = false
        var exisistsYet = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if (exercise.name == data.value(forKey: "name") as! String) {
                    exisistsYet = true
                    break
                }
            }
            //SE NON E' PRESENTE NEL COREDATA ALLORA POSSO AGGIUNGERLO
            if(!exisistsYet) {
                //SALVATAGGIO SU EXERCISES
                let entityExercises = NSEntityDescription.entity(forEntityName: "Exercises", in: context)
                let tmpEntity = NSManagedObject(entity: entityExercises!, insertInto: context)
                tmpEntity.setValue(exercise.name, forKey: "name")
                tmpEntity.setValue([0], forKey: "weight")
                tmpEntity.setValue([Date()], forKey: "date")
                
                do {
                    try context.save()
                    print(exercise.name)
                    print("esercizi salvati")
                } catch {
                    print("errore nel salvataggio degli esercizi")
                }
            }
        } catch {
            print("errore nel caricamento dell'array weight")
        }
    }
    
    func deleteAllRecords() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercises")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
    }

}

extension ExerciseListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //restituisce il numero di esercizi
        return exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //restituisce il nome dell'esercizio all' n-esima riga (indexPath.row)
        let exercise = exercises[indexPath.row]
        
        //restituisce la cella
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell") as! ExerciseCell
        
        //setto il titolo della scheda nella cella opportuna
        cell.setExercise(title: exercise.name, primaryMuscle: exercise.primaryMuscle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indico al navicator controller a quale controller passare dopo la selezione
        let vc = storyboard?.instantiateViewController(withIdentifier: "ExerciseScreen") as? ExerciseScreen
        
        vc?.exercise = exercises[indexPath.row]
        
        //passo da questo viewcontroller al prossimo
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
