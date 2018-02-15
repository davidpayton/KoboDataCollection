//
//  QuestionViewController.swift
//  Kobo
//
//  Created by KobeBryant on 12/7/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//

import UIKit
import Firebase
import SQLite
class QuestionViewController: UIViewController {

    @IBOutlet weak var textviewQuestion: UITextView!
    var refQuestions: DatabaseReference!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        refQuestions = Database.database().reference().child("questions")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func comitQuesion(_ sender: Any) {
        addQuestions()
        
    }
    
    func addQuestions()
    {
            //generating a new key inside artists node
            //and also getting the generated key
            let key = refQuestions.childByAutoId().key
            
            //creating artist with the given values
            let question = ["id":key,
                          "questionQuestion": textviewQuestion.text! as String,
                          "questionAnswer": "Answer:" as String
            ]
            
            //adding the artist inside the generated unique key
            refQuestions.child(key).setValue(question)
            
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
