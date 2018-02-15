//
//  SettingViewController.swift
//  Kobo
//
//  Created by KobeBryant on 11/24/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//

import UIKit
import SQLite
class SettingViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{

    

    @IBOutlet weak var textFirstName: UITextField!
    @IBOutlet weak var textLastName: UITextField!
    @IBOutlet weak var textJob: UITextField!
    @IBOutlet weak var textCountry: UITextField!
    @IBOutlet weak var textDate: UITextField!
    let countries = ["Afghanistan","Albania","Algeria","Andorra","Angola","Anguilla","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas"
        ,"Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Botswana","Brazil","British Virgin Islands"
        ,"Brunei","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde","Cayman Islands","Chad","Chile","China","Colombia","Congo","Cook Islands","Costa Rica"
        ,"Cote D Ivoire","Croatia","Cruise Ship","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador","Equatorial Guinea"
        ,"Estonia","Ethiopia","Falkland Islands","Faroe Islands","Fiji","Finland","France","French Polynesia","French West Indies","Gabon","Gambia","Georgia","Germany","Ghana"
        ,"Gibraltar","Greece","Greenland","Grenada","Guam","Guatemala","Guernsey","Guinea","Guinea Bissau","Guyana","Haiti","Honduras","Hong Kong","Hungary","Iceland","India"
        ,"Indonesia","Iran","Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan","Kenya","Kuwait","Kyrgyz Republic","Laos","Latvia"
        ,"Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macau","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania"
        ,"Mauritius","Mexico","Moldova","Monaco","Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Namibia","Nepal","Netherlands","Netherlands Antilles","New Caledonia"
        ,"New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palestine","Panama","Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal"
        ,"Puerto Rico","Qatar","Reunion","Romania","Russia","Rwanda","Saint Pierre &amp; Miquelon","Samoa","San Marino","Satellite","Saudi Arabia","Senegal","Serbia","Seychelles"
        ,"Sierra Leone","Singapore","Slovakia","Slovenia","South Africa","South Korea","Spain","Sri Lanka","St Kitts &amp; Nevis","St Lucia","St Vincent","St. Lucia","Sudan"
        ,"Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Timor L'Este","Togo","Tonga","Trinidad &amp; Tobago","Tunisia"
        ,"Turkey","Turkmenistan","Turks &amp; Caicos","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States","United States Minor Outlying Islands","Uruguay","Uzbekistan","Venezuela","Vietnam","Virgin Islands (US)"
        ,"Yemen","Zambia","Zimbabwe"];
    
    var database: Connection!
    let userTable = Table("user")
    let id = Expression<Int>("id")
    let firstname = Expression<String>("firstname")
    let lastname = Expression<String>("lastname")
    let job = Expression<String>("job")
    let country = Expression<String>("country")
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch  {
            print("error")
        }
        // Do any additional setup after loading the view.
        
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users{
                self.textFirstName.text = user[self.firstname]
                self.textLastName.text = user[self.lastname]
                self.textJob.text = user[self.job]
                self.textCountry.text = user[self.country]
            }

        } catch  {
            print(error)
        }
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textCountry.inputView = pickerView
        textFirstName.isUserInteractionEnabled = false
        textLastName.isUserInteractionEnabled = false
        textJob.isUserInteractionEnabled = false
        textCountry.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textCountry.text = countries[row]
        self.view.endEditing(true)
    }
    @IBAction func saveProfile(_ sender: Any) {
     
        do {
            try self.database.run(self.userTable.create(temporary: false, ifNotExists: true, withoutRowid: false){
                (table) in
                table.column(self.id, primaryKey:true)
                table.column(self.firstname)
                table.column(self.lastname)
                table.column(self.job)
                table.column(self.country)
            }	)
        } catch  {
            print(error)
            }
        
        let firstname = self.textFirstName.text
        let lastname = self.textLastName.text
        let job = self.textJob.text
        let country = self.textCountry.text
        
        let insertUser = self.userTable.insert(self.firstname <- firstname!, self.lastname <- lastname!, self.job <- job!, self.country <- country!)

          do {
                        try self.database.run(insertUser)
                        print(insertUser)
                    } catch    {
                        print(error)
            }

        textFirstName.isUserInteractionEnabled = false
        textLastName.isUserInteractionEnabled = false
        textJob.isUserInteractionEnabled = false
        textCountry.isUserInteractionEnabled = false

        
    }
    
    @IBAction func editSetting(_ sender: Any) {
        textFirstName.isUserInteractionEnabled = true
        textLastName.isUserInteractionEnabled = true
        textJob.isUserInteractionEnabled = true
        textCountry.isUserInteractionEnabled = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
