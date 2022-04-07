//
//  LiveWorkoutScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 15/05/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox
import CoreGraphics
import UserNotifications

class LiveWorkoutScreen: UIViewController, UITextFieldDelegate {
    
    var workout : Schedule = Schedule(title: "", exercises: [])
    var images : [UIImage] = []
    var seconds : Float = 0
    var sectimer : Timer?
    var isRunning = false
    var setscount = 0
    var sets = 0
    var exercisecount = 0
    var totalexercises = 0
    var finished = false
    var exHasChanged = false
    var picker : UIPickerView! = UIPickerView()
    var toolbar = UIToolbar()
    var pickerWeight = [[Int]]()
    
    @IBOutlet weak var labelExerciseName: UILabel!
    @IBOutlet weak var imageCurrentExercise: UIImageView!
    @IBOutlet weak var buttonDone: UIButton!
    @IBOutlet weak var buttonPause: UIButton!
    @IBOutlet weak var labelCrono: UILabel!
    @IBOutlet weak var labelSet: UILabel!
    @IBOutlet weak var labelRep: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var buttonWeight: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = workout.title
        //print(workout.title)
        
        //Aggiorno le variabili dei dati della scheda
        buttonDone.layer.cornerRadius = 20
        buttonPause.isEnabled = false   //setto il bottone di pausa disabilitato al caricamento della view
        
        populateWeightArray()
        
        totalexercises = workout.exercises.count
        sets = workout.exercises[exercisecount].sets
        seconds = Float(workout.exercises[exercisecount].rest)
        
        labelExerciseName.text = workout.exercises[exercisecount].exercise
        imageCurrentExercise.image = getExercise(exercise: workout.exercises[exercisecount].exercise).getImage()
        labelRep.text = String(workout.exercises[exercisecount].reps)
        labelSet.text = String(setscount) + "/" + String(sets)
        labelWeight.text = String(getWeightFromData())
        
        picker.delegate = self
        picker.dataSource = self
        
        refreshTimeLabel()
        
        //CENTRO NOTIFICHE
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
        }
        
    }
    
    /*
    @objc func tap(gestureReconizer: UITapGestureRecognizer) {
        print("*")
        picker.isHidden = false
    }
    */
    
    @IBAction func registerWeight(_ sender: Any) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 400, width: UIScreen.main.bounds.size.width, height: 320)
        
        self.view.addSubview(picker)
        
        toolbar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 395, width: UIScreen.main.bounds.size.width, height: 40))
        //toolbar.barStyle = .blackTranslucent
        toolbar.items = [UIBarButtonItem.init(title: "Fatto", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolbar)
        buttonWeight.isEnabled = false
    }
    
    @objc func onDoneButtonTapped() {
        toolbar.removeFromSuperview()
        picker.removeFromSuperview()
        buttonWeight.isEnabled = true
    }
    
    @IBAction func done(_ sender: Any) {
        if sets == 1 {
            sectimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
            check2Change()
        } else if !isRunning {
            seconds = Float(workout.exercises[exercisecount].rest)
            check2Change()
            if !exHasChanged {
                //se il timer non sta andando e non è finito il workout
                if (!finished) {
                    sectimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
                    isRunning = true
                    buttonPause.isEnabled = true
                    setscount += 1
                    labelSet.text = String(setscount) + "/" + String(sets)
                    createNotification(rest: seconds)
                }
            }
        } else {
            seconds = Float(workout.exercises[exercisecount].rest)
            check2Change()
            if !exHasChanged {
                //se il timer sta andando e non è finito il workout
                if (!finished) {
                    stopAlarm()
                    // TODO AUEMENTARE SETS++
                    sectimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
                    isRunning = true
                    buttonPause.isEnabled = true
                    setscount += 1
                    labelSet.text = String(setscount) + "/" + String(sets)
                    createNotification(rest: seconds)
                }
            }
        }
        exHasChanged = false
    }
    
    func createNotification(rest : Float) {
        //Creo il notification content
        let content = UNMutableNotificationContent()
        content.title = "Tempo finito!"
        content.body = "Il riposo è terminato, puoi tornare all'allenamento"
        
        let countdownNotification = Date().addingTimeInterval(Double(rest))
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: countdownNotification)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //Creo la request
        //let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: "timerFinito", content: content, trigger: trigger)
        
        //Rimuovo le precedenti notifiche
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerFinito"])
        //Registro la richiesta
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    //DECREMENTA I VALORI DEL TIMER DI 0.01 SECONDI OGNI CICLO
    @objc func counter() {
        seconds -= 0.01
        refreshTimeLabel()
        //print(seconds)
        //se arriva a 0 il timer sic ferma
        if (seconds <= 1.00) {
            stopAlarm()
            buttonPause.isEnabled = false
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    //AGGIORNA I VALORI DEL TIMER
    func refreshTimeLabel() {
        //MM:SS:mm
        let flooredcounter = Int(floor(seconds))
        
        let min = flooredcounter / 60
        var minuteString = "\(min)"
        if min < 10 {
            minuteString = "0\(min)"
        }
        
        let sec = flooredcounter % 60
        var secString = "\(sec)"
        if sec < 10 {
            secString = "0\(sec)"
        }
        
        let dsec = String(format: "%.2f", seconds).components(separatedBy: ".").last!
        
        //setta il tempo nella label labelCrono
        labelCrono.text = "\(minuteString):\(secString),\(dsec)"
    }
    
    //FERMA IL TIMER E NE CREA UNO NUOVO (PER EVITARE SOVRAPPOSIZIONI DI PIU TIMER ALLA VOLTA)
    func stopAlarm() {
        self.sectimer!.invalidate()
        self.sectimer = nil
        isRunning = false
        self.sectimer = Timer()
    }
    
    //CONTROLLA SE I SET FATTI SONO UGUALI A QUELLI PREVISTI, SE COSì ALLORA CAMBIA ESERCIZIO
    func check2Change() {
        if setscount == sets-1 {
            
            //salva il nuovo peso
            let new_weight = (labelWeight.text! as NSString).floatValue
            saveNewWeight(exercise: getExercise(exercise: workout.exercises[exercisecount].exercise), new_weight: new_weight)
        
            setscount = 0
            exercisecount += 1
            if exercisecount == totalexercises {
                //print("fine")
                finished = true
                stopAlarm()
                //Rimuovo le precedenti notifiche
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerFinito"])
                let alert = UIAlertController(title: "Ce l'hai fatta!", message: "Hai completato il tuo allenamento anche oggi, continua così", preferredStyle: .alert)
                let close = UIAlertAction(title: "Fine", style: .cancel, handler: {_ in
                    CATransaction.setCompletionBlock({
                        self.navigationController?.popViewController(animated: true)
                    })
                })
                alert.addAction(close)
                //alert.addAction(UIAlertAction(title: "Chiudi", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                seconds = Float(workout.exercises[exercisecount].rest)
                sets = workout.exercises[exercisecount].sets
                imageCurrentExercise.image = getExercise(exercise: workout.exercises[exercisecount].exercise).getImage()
                labelExerciseName.text = workout.exercises[exercisecount].exercise
                labelSet.text = String(setscount) + "/" + String(sets)
                labelRep.text = String(workout.exercises[exercisecount].reps)
                labelWeight.text = String(getWeightFromData())
                stopAlarm()
                refreshTimeLabel()
                exHasChanged = true
            }
        }
    }
    
    //FERMA IL TIMER E IMPOSTA LA LABEL PAUSA/RIPRENDI
    @IBAction func pause(_ sender: Any) {
        if (isRunning == true) {
            //FERMA IL TIMER
            self.sectimer!.invalidate()
            isRunning = false
            buttonPause.setTitle("Riprendi", for: .normal)
            //Rimuovo le precedenti notifiche
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["timerFinito"])
        } else {
            //RIPRENDE IL TIMER ALTRIMENTI
            sectimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.counter), userInfo: nil, repeats: true)
            createNotification(rest: getSecondsFromTimer())
            isRunning = true
            buttonPause.setTitle("Pausa", for: .normal)
        }
    }
    
    func getSecondsFromTimer() -> Float{
        var time1 = labelCrono.text?.components(separatedBy: ",")
        var time2 = time1?[0].components(separatedBy: ":")
        let millisec = Float("0." + String((time1?[1])!))
        let sec = Float(time2![1])
        let minutes = Float(time2![0])
        return (minutes!*60+sec!+millisec!)
    }
    
    
    func getExercise(exercise: String) -> Exercise {
        var res : Exercise? = nil
        for tmp in exercises {
            if(tmp.name == exercise) {
                res = tmp
            }
        }
        return res!
    }
    
    func populateWeightArray() {
        var kilos = [Int]()
        for k in 0...300 {
            kilos.append(k)
        }
        var grams = [Int]()
        for g in 0...3 {
            grams.append(g*25)
        }
        pickerWeight = [kilos,grams]
    }
    
    func getWeightFromData() -> Float {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercises")
        request.returnsObjectsAsFaults = false
        var weight : Float = 0.0
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if (workout.exercises[exercisecount].exercise == data.value(forKey: "name") as! String) {
                    var weights = data.value(forKey: "weight") as! [Float]
                    if (weights != []) {
                        weight = weights[weights.count-1]
                    }
                }
            }
        } catch {
            print("errore nel caricamento dell'array weight")
        }
        return weight
    }
    
    func getAllWeightFromData() -> [Float] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercises")
        request.returnsObjectsAsFaults = false
        var weight : [Float] = [0.0]
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if (workout.exercises[exercisecount].exercise == data.value(forKey: "name") as! String) {
                    let weights = data.value(forKey: "weight") as! [Float]
                    if (weights != []) {
                        weight = weights
                    }
                }
            }
        } catch {
            print("errore nel caricamento dell'array weight")
        }
        return weight
    }
    
    func getAllDatesFromData() -> [Date] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercises")
        request.returnsObjectsAsFaults = false
        var date = [Date]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if (workout.exercises[exercisecount].exercise == data.value(forKey: "name") as! String) {
                    let dates = data.value(forKey: "date") as! [Date]
                    if (dates != []) {
                        date = dates
                    }
                }
            }
        } catch {
            print("errore nel caricamento dell'array date")
        }
        return date
    }
    
    func saveNewWeight(exercise: Exercise, new_weight: Float) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercises")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if (exercise.name == data.value(forKey: "name") as! String) {
                    var newWeightArray = getAllWeightFromData()
                    newWeightArray.append(new_weight)
                    var newDateArray = getAllDatesFromData()
                    newDateArray.append(Date())
        
                    //SALVATAGGIO SU EXERCISES
                    data.setValue(newWeightArray, forKey: "weight")
                    data.setValue(newDateArray, forKey: "date")
                
                    
                    do {
                        try context.save()
                        print(newWeightArray)
                        print("peso esercizio aggiunto correttamente")
                    } catch {
                        print("errore nel nuovo salvataggio peso")
                    }
                    break
                }
            }
        } catch {
            print("errore nel caricamento dell'array weight")
        }
    }
    
}

extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension LiveWorkoutScreen: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerWeight[component].count
        /*if ((component==0) || (component==2)) {
            return self.pickerWeight[component].count
        } else {
            return 1
        }*/
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component==0 {
            return String(self.pickerWeight[component][row])
        } else {
            return "." + String(self.pickerWeight[component][row])
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let kilos =  String(pickerWeight[0][pickerView.selectedRow(inComponent: 0)])
        let grams = String(pickerWeight[1][pickerView.selectedRow(inComponent: 1)])
        labelWeight.text =   kilos + "." + grams
        
    }
}
