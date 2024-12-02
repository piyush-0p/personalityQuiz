//
//  ResultsViewController.swift
//  personalityQuiz
//
//  Created by Batch - 2 on 27/11/24.
//

import UIKit

class ResultsViewController: UIViewController {
    var responses: [Answer]
    
    @IBOutlet var resultAnswerLabel: UILabel!
    
    @IBOutlet var resultDefinitionLabel: UILabel!
    
    init?(coder: NSCoder, responses: [Answer]){
        self.responses = responses
        super.init(coder: coder)
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implementd")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

     calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
    func calculatePersonalityResult(){
        let frequencyOfAnswers = responses.reduce(into: [AnimalType: Int]()){
            (counts, answer) in
            if let existingCount = counts[answer.type]{
                counts[answer.type] = existingCount + 1
            }else{
                counts[answer.type] = 1
            }
        }
        let frequentAnswerSorted = frequencyOfAnswers.sorted(by: { (pair1,pair2) in return pair1.value > pair2.value})
        let mostCommonAnswer = frequentAnswerSorted.sorted { $0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "You are a\(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    
    
}
