//
//  PopUpBMI.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 29/08/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import CoreData

class PopUpBMI: UIViewController {
    
    @IBOutlet weak var viewModal: UIView!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var closeWindowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModal.layer.cornerRadius = 10
        generateBMI()
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateBMI() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        
        do {
            var res : Float = 0
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                var weight = data.value(forKey: "weight") as! [Float]
                let height = data.value(forKey: "height") as! Float
                let heightq = Float((height/100)*(height/100))
                let currentWeight = weight[(weight.count)-1]
                res = currentWeight/heightq
                //print("w: " + String(currentWeight) + "\nh: " + String(heightq))
            }
            print(res)
            
            switch res {
            case 0..<16.5:
                labelResult.text = "Sottopeso severo"
                labelResult.textColor = .red
            case 16.5...18.4:
                labelResult.text = "Sottopeso"
                labelResult.textColor = .orange
            case 18.5...24.9:
                labelResult.text = "Normale"
                labelResult.textColor = .green
            case 25...30:
                labelResult.text = "Sovrappeso"
                labelResult.textColor = .orange
            case 30.1...34.9:
                labelResult.text = "Obesità primo grado"
                labelResult.textColor = .red
            case 35...40:
                labelResult.text = "Obesità secondo grado"
                labelResult.textColor = .red
            case 40.1...:
                labelResult.text = "Obesità terzo grado"
                labelResult.textColor = .red
            default:
                labelResult.text = ""
            }
        } catch {
            print("errore nel caricamento del profilo")
        }
    }

}
