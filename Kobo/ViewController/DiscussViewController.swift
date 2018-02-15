//
//  DiscussViewController.swift
//  Kobo
//
//  Created by KobeBryant on 11/24/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//

import UIKit
import Firebase

class DiscussViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchDisplayDelegate {

    

    @IBOutlet weak var tableViewQuestions: UITableView!
    var questionList = [QuestionModel]()
    var refQuestions: DatabaseReference!
    var speciesSearchResults:Array<QuestionModel>?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        refQuestions = Database.database().reference().child("questions")
        refQuestions.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.questionList.removeAll()
                
                //iterating through all the values
                for questions in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let questionObject = questions.value as? [String: AnyObject]
                    let questionQuestion  = questionObject?["questionQuestion"]
                    let Id  = questionObject?["id"]
                    let questionAnswer = questionObject?["questionAnswer"]
                    
                    //creating artist object with model and fetched values
                    let question = QuestionModel(id: Id as! String?, question: questionQuestion as! String?, answer: questionAnswer as! String?)
                    
                    //appending it to list
                    self.questionList.append(question)
                }
                
                //reloading the tableview
                self.tableViewQuestions.reloadData()
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionTableViewCell
        
        //the artist object
        let question: QuestionModel
        
        //getting the artist of selected position
        question = questionList[indexPath.row]
        
        //adding values to labels
        cell.tvcellQuestion.text = question.question
        //cell.tvcellAnswer.text = question.answer
        
        //returning cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //getting the selected artist
        let question  = questionList[indexPath.row]
        
        //building an alert
        let alertController = UIAlertController(title: "Q&Answer", message: "Give new answers for the other peoples ", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting artist id
            let id = question.id
            
            //getting new values
            let questionQuestion = alertController.textFields?[0].text
            let questionAnswer = alertController.textFields?[1].text
            
            //calling the update method to update artist
            self.updateQuestion(id: id!, question: questionQuestion!, answer: questionAnswer!)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding two textfields to alert
        alertController.addTextField { (textField) in
            textField.text = question.question
        }
        alertController.addTextField { (textField) in
            textField.text = question.answer
        }
        
        //adding action
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //presenting dialog
        present(alertController, animated: true, completion: nil)
    }
    
    func updateQuestion(id:String, question:String, answer:String){
        //creating artist with the new given values
        let artist = ["id":id,
                      "questionQuestion": question,
                      "questionAnswer": answer
        ]
        
        //updating the artist using the key of the artist
        refQuestions.child(id).setValue(artist)
        
        //displaying message
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
