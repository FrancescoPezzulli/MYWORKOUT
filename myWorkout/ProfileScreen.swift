//
//  ProfileScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 31/07/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import CoreData

class ProfileScreen: UIViewController {

    @IBOutlet weak var imageMF: UIImageView!
    @IBOutlet weak var segmentMF: UISegmentedControl!
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var textfieldSurname: UITextField!
    @IBOutlet weak var textfieldBirth: UITextField!
    @IBOutlet weak var textfieldWeight: UITextField!
    @IBOutlet weak var textfieldHeight: UITextField!
    @IBOutlet weak var textfieldGoalWeight: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonInfo: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentMF.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for:.valueChanged)
        imageMF.tag = 1
        buttonInfo.layer.cornerRadius = 10
        buttonSave.layer.cornerRadius = 10
        //deleteData()
        getData()
    }
    
    /*
    @IBAction func textfieldBirthEditing(_ sender: Any) {
        let datePickerView : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        textfieldBirth.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        textfieldBirth.text = dateFormatter.string(from: sender.date)
    }
    */
    
    @IBAction func textfieldWeightEditing(_ sender: Any) {
        
    }
    
    @IBAction func textfieldHeightEditing(_ sender: Any) {
    }
    
    @IBAction func textfieldGoalEditing(_ sender: Any) {
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if segmentMF.selectedSegmentIndex == 0 {
            imageMF.image = #imageLiteral(resourceName: "icons8-user-male-96")
            imageMF.tag = 1
        } else {
            imageMF.image = #imageLiteral(resourceName: "icons8-user-female-skin-type-4-96")
            imageMF.tag = 2
            
        }
    }
    
    func deleteData() {
        //METODO USATO PER ELIMINARE TUTTI I DATI DA UNA TABELLA
        // Create Fetch Request
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
         
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
         
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            // Error Handling
        }
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if(result.count != 0) {
                for data in result as! [NSManagedObject] {
                    if ((data.value(forKey: "sex") as! String) == "m") {
                        segmentMF.selectedSegmentIndex = 0
                    } else  {
                        segmentMF.selectedSegmentIndex = 0
                    }
                    textfieldName.text = (data.value(forKey: "name") as! String)
                    textfieldSurname.text = (data.value(forKey: "surname") as! String)
                    textfieldBirth.text = String(data.value(forKey: "age") as! Int)
                    textfieldHeight.text = String(data.value(forKey: "height") as! Int)
                    var weightarray = (data.value(forKey: "weight") as! [Float])
                    textfieldWeight.text = String(weightarray[(weightarray.count)-1])
                    textfieldGoalWeight.text = String(data.value(forKey: "goalweight") as! Float)
                    //print(data.value(forKey: "date") as! [Date])
                }
            }
        } catch {
            print("errore nel caricamento del profilo")
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if (textfieldName.text != "" && textfieldSurname.text != "" && textfieldBirth.text != "" && textfieldWeight.text != "" && textfieldHeight.text != "" && textfieldGoalWeight.text != "" ) {
            //posso salvare
            
            //SALVATAGGIO SU PROFILE
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entityProfile = NSEntityDescription.entity(forEntityName: "Profile", in: context)
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
            request.returnsObjectsAsFaults = false
            
            do {
                let result:NSArray? = try context.fetch(request) as NSArray
                if let results = result {
                    if results.count > 0 {
                    let objectupdate = results[0] as! NSManagedObject
                    var weightarray = objectupdate.value(forKey: "weight") as! [Float]
                    var datearray = objectupdate.value(forKey: "date") as! [Date]
                    objectupdate.setValue(textfieldName.text, forKey: "name")
                    objectupdate.setValue(textfieldSurname.text, forKey: "surname")
                    objectupdate.setValue(Int(textfieldBirth.text!), forKey: "age")
                        
                    weightarray.append((textfieldWeight.text! as NSString).floatValue)
                    objectupdate.setValue(weightarray, forKey: "weight")
                        
                    datearray.append(Date())
                    objectupdate.setValue(datearray, forKey: "date")
                        
                    objectupdate.setValue(Int(textfieldHeight.text!), forKey: "height")
                    objectupdate.setValue((textfieldGoalWeight.text! as NSString).floatValue, forKey: "goalweight")
                    
                    if imageMF.tag == 1 {
                        objectupdate.setValue("m", forKey: "sex")
                    } else {
                        objectupdate.setValue("f", forKey: "sex")
                    }
                    
                } else {
                    var weightarray : [Float] = []
                    var datearray : [Date] = []
                    let tmpEntity = NSManagedObject(entity: entityProfile!, insertInto: context)
                    tmpEntity.setValue(textfieldName.text, forKey: "name")
                    tmpEntity.setValue(textfieldSurname.text, forKey: "surname")
                    tmpEntity.setValue(Int(textfieldBirth.text!), forKey: "age")
                        
                    weightarray.append((textfieldWeight.text! as NSString).floatValue)
                    tmpEntity.setValue(weightarray, forKey: "weight")
                        
                    datearray.append(Date())
                    tmpEntity.setValue(datearray, forKey: "date")
                        
                    tmpEntity.setValue(Int(textfieldHeight.text!), forKey: "height")
                    tmpEntity.setValue((textfieldGoalWeight.text! as NSString).floatValue, forKey: "goalweight")
                    
                    if imageMF.tag == 1 {
                        tmpEntity.setValue("m", forKey: "sex")
                    } else {
                        tmpEntity.setValue("f", forKey: "sex")
                    }
                }
                } else {
                    print("oggetto nil")
                }
                
                try context.save()
                print("profilo salvato")
                let alert = UIAlertController(title: "Profilo salvato", message: "Il profilo è stato salvato correttamente", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } catch let error as NSError {
                NSLog("Unresolved error \(error), \(error.userInfo)")
                print("errore nel salvataggio")
            }
            
        } else {
            let alert = UIAlertController(title: "Errore!", message: "Hai lasciato qualche campo vuoto, compila tutto quanto", preferredStyle: .alert)
            let close = UIAlertAction(title: "Chiudi", style: .cancel, handler: {_ in
                CATransaction.setCompletionBlock({
                    self.navigationController?.popViewController(animated: true)
                })
            })
            alert.addAction(close)
            //alert.addAction(UIAlertAction(title: "Chiudi", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func showInfo(_ sender: Any) {
        //mostra la finestra modal PopUpBMI
        let vc = storyboard?.instantiateViewController(withIdentifier: "PopUpBMI") as? PopUpBMI
        vc?.modalTransitionStyle = .crossDissolve
        self.present(vc!, animated: true, completion: nil)
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
