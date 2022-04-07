//
//  PopUpAddExercise.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 13/06/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit

class PopUpAddExercise: UIViewController {

    @IBOutlet weak var viewModal: UIView!
    @IBOutlet weak var textViewExercise: UITextField!
    @IBOutlet weak var textViewSets: UITextField!
    @IBOutlet weak var textViewReps: UITextField!
    @IBOutlet weak var textViewRest: UITextField!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    var delegate : AddRowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let picker = UIPickerView()
        picker.delegate = self
        
        
        textViewExercise.inputView = picker
        textViewExercise.delegate = self
        viewModal.layer.cornerRadius = 10
        buttonCancel.layer.cornerRadius = 10
        buttonNext.layer.cornerRadius = 10
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        if (textViewExercise.text == "" || textViewSets.text == "" || textViewReps.text == "" || textViewRest.text == "") {
            print("errore, campo/i vuoti")
        } else {
            delegate!.didAddRow(exercise: textViewExercise.text!, sets: textViewSets.text!, reps: textViewReps.text!, rest: textViewRest.text!)
            /*
            exercisesOfWorkout.append(CustomEx(exercise: textViewExercise.text!, sets: Int(textViewSets.text ?? "0")!, reps: Int(textViewReps.text ?? "0")!, rest: Int(textViewRest.text ?? "0")!, weight: 0))
            .tableView.reloadData()
            */
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let prev: NewScheduleScreen  = segue.destination as! NewScheduleScreen
        
        prev.tableView.reloadData()
    }
    */

}

extension PopUpAddExercise: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercises.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exercises[row].name
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textViewExercise.text = exercises[row].name
    }
}

//permette di non modificare il textfield dell'esercizio
extension PopUpAddExercise: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
