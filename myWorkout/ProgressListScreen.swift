//
//  ProgressListScreen.swift
//  myWorkout
//
//  Created by Francesco Pezzulli on 22/06/2019.
//  Copyright © 2019 Francesco Pezzulli. All rights reserved.
//

import UIKit
import Charts
import CoreData

class ProgressListScreen: UIViewController {
    
    var dataEntries : [ChartDataEntry] = []
    var toolbar = UIToolbar()
    let picker = UIPickerView()
    var onProfileStatus = false

    @IBOutlet weak var mChart: LineChartView!
    @IBOutlet weak var selectorTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        selectorTextField.delegate = self
        mChart.delegate = self
        toolbar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 395, width: UIScreen.main.bounds.size.width, height: 40))
        //toolbar.barStyle = .blackTranslucent
        toolbar.items = [UIBarButtonItem.init(title: "Fatto", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        selectorTextField.inputView = picker
        selectorTextField.inputAccessoryView = toolbar
        mChart.noDataText = "Nessun dato dal momento disponibile!"

        // Do any additional setup after loading the view.
    }
    
    /*@objc func showPicker() {
        self.view.addSubview(toolbar)
        self.view.addSubview(picker)
    }*/
    
    @objc func onDoneButtonTapped() {
        toolbar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func setChart(values: [Float]) {
        if (values[0] == 0 && values.count <= 1) {
            mChart.noDataText = "Nessun dato dal momento disponibile!"
        } else {
        for i in 0..<values.count {
            print("chart point : \(values[i])")
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        let line1 = LineChartDataSet(entries: dataEntries, label: "Kg")
        line1.colors = [NSUIColor.white]
        line1.mode = .linear
        line1.cubicIntensity = 0.2
        
        let gradient = getGradientFilling()
        line1.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        line1.drawFilledEnabled = true
        
        let data = LineChartData()
        data.addDataSet(line1)
        mChart.data = data
        mChart.setScaleEnabled(false)
        mChart.animate(xAxisDuration: Double(values.count)*0.03)
        mChart.drawGridBackgroundEnabled = false
        mChart.xAxis.drawAxisLineEnabled = false
        mChart.xAxis.drawGridLinesEnabled = false
        mChart.leftAxis.drawAxisLineEnabled = true
        mChart.leftAxis.drawGridLinesEnabled = false
        mChart.rightAxis.drawAxisLineEnabled = false
        mChart.rightAxis.drawGridLinesEnabled = false
        mChart.legend.enabled = false
        mChart.xAxis.enabled = true
        mChart.leftAxis.enabled = true
        mChart.rightAxis.enabled = false
        mChart.xAxis.drawLabelsEnabled = true
        mChart.xAxis.labelPosition = .bottom
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short

        /*let graphableDatesAsDouble = customHistoricalSamples.map { $0.date.timeIntervalSince1970 }
        let series = ChartSeries(graphableVales)
        series.area = true
        chart.xLabels = graphableDatesAsDouble
        chart.xLabelsFormatter = { dateFormatter.string(from: Date(timeIntervalSince1970: $1)) }
        chart.add(series)*/
        }
        
        
    }
    
    /// Creating gradient for filling space under the line chart
    private func getGradientFilling() -> CGGradient {
        // Setting fill gradient color
        let coloTop = UIColor(red: 105/255, green: 202/255, blue: 244/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 28/255, green: 127/255, blue: 204/255, alpha: 1).cgColor
        // Colors of the gradient
        let gradientColors = [coloTop, colorBottom] as CFArray
        // Positioning of the gradient
        let colorLocations: [CGFloat] = [0.0, 1.0]
        // Gradient Object
        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
    }
    
    func getAllWeightFromData() -> [Float] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercises")
        request.returnsObjectsAsFaults = false
        var weight : [Float] = [0.0]
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if (selectorTextField.text == data.value(forKey: "name") as? String) {
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
    
    func getAllWeightFromProfile() -> [Float] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        var weight : [Float] = [0.0]
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let weights = data.value(forKey: "weight") as! [Float]
                if (weights != []) {
                    weight = weights
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
                if (selectorTextField.text == data.value(forKey: "name") as? String) {
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
    
    func getAllDatesFromProfile() -> [Date] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        request.returnsObjectsAsFaults = false
        var date = [Date]()
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let dates = data.value(forKey: "date") as! [Date]
                if (dates != []) {
                    date = dates
                }
            }
        } catch {
            print("errore nel caricamento dell'array date")
        }
        return date
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

extension ProgressListScreen: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exercises.count + 1
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row==0 {
            return "Peso corporeo"
        } else {
            return exercises[row-1].name
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row==0 {
            selectorTextField.text = "Peso corporeo"
            mChart.clear()
            dataEntries = []
            setChart(values: getAllWeightFromProfile())
            onProfileStatus = true
        } else {
            selectorTextField.text = exercises[row-1].name
            mChart.clear()
            dataEntries = []
            setChart(values: getAllWeightFromData())
            onProfileStatus = false
        }
    }
}

//permette di non modificare il textfield dell'esercizio
extension ProgressListScreen: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension ProgressListScreen: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        weightLabel.text = String(entry.y) + " KG"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        var date : Date
        if onProfileStatus {
            date = getAllDatesFromProfile()[Int(entry.x)]
        } else {
            date = getAllDatesFromData()[Int(entry.x)]
        }
        //let date = getAllDatesFromData()[Int(entry.x)]
        dateLabel.text = dateFormatterPrint.string(from: date)
    }
}
