//
//  QuestionModel.swift
//  Kobo
//
//  Created by KobeBryant on 12/7/17.
//  Copyright © 2017 KobeBryant. All rights reserved.
//

import Foundation

class QuestionModel{
    var id: String?
    var question: String?
    var answer: String?
    
    init(id: String?, question: String?, answer: String?){
        self.id = id
        self.question = question
        self.answer = answer
    }
}
