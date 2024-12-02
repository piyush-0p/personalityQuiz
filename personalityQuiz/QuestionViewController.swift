//
//  QuestionViewController.swift
//  personalityQuiz
//
//  Created by Batch - 2 on 27/11/24.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    
    
    @IBOutlet var multiStackView: UIStackView!
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var rangedLabel1: UILabel!
    @IBOutlet var rangedLabel2: UILabel!
    
    @IBOutlet var rangedSlider: UISlider!
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    var question: [Question] = [
    Question(
        text: "Which food do you like the most?",
        type: .single,
        answers: [
            Answer(text: "Steak", type: .lion),
            Answer(text: "Fish", type: .cat),
            Answer(text: "Carrot", type: .rabbit),
            Answer(text: "Corn", type: .turtle)
        ]
    ),
    
     Question(
        text: "Which activities do you enjoy?",
        type: .multiple,
        answers: [
            Answer(text: "Swimming", type: .turtle),
            Answer(text: "Sleeping", type: .cat),
            Answer(text: "Cuddling", type: .rabbit),
            Answer(text: "Eating", type: .lion)
        ]
        ),
      
      Question(
        text: "how much do you enjoy car rides?",
        type: .ranged,
        answers: [
            Answer(text: "I dislike then", type: .cat),
            Answer(text: "I get a little nervous", type: .rabbit),
            Answer(text: "I barely notice them", type: .turtle),
            Answer(text: "I love them", type: .lion)
        ]
        )
    ]
    
    var questionIndex = 0
    var answerChosen: [Answer] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBSegueAction func showResult(_ coder: NSCoder) -> ResultsViewController? {
        return ResultsViewController(coder: coder, responses: answerChosen)
    }
    
    func nextQuestion(){
        questionIndex += 1
        if questionIndex < question.count {
            updateUI()
        }else{
            performSegue(withIdentifier: "Results", sender: nil)
        }
    }
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = question[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answerChosen.append(currentAnswer[0])
        case singleButton2:
            answerChosen.append(currentAnswer[1])
        case singleButton3:
            answerChosen.append(currentAnswer[2])
        case singleButton4:
            answerChosen.append(currentAnswer[3])
        default:
            break
        }
         nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswer = question[questionIndex].answers
        if multiSwitch1.isOn {
            answerChosen.append(currentAnswer[0])
        }
        if multiSwitch2.isOn {
            answerChosen.append(currentAnswer[1])
        }
        if multiSwitch3.isOn {
            answerChosen.append(currentAnswer[2])
        }
        if multiSwitch4.isOn {
            answerChosen.append(currentAnswer[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed() {
        let currentAnswers = question[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answerChosen.append(currentAnswers[index])
        nextQuestion()
    }
    func updateUI() {
        singleStackView.isHidden = true
        multiStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        let currentQuestion = question[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totolProgress = Float(questionIndex) / Float(question.count)
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totolProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    }
    
    func updateSingleStack(using answer: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answer[0].text, for: .normal)
        singleButton2.setTitle(answer[1].text, for: .normal)
        singleButton3.setTitle(answer[2].text, for: .normal)
        singleButton4.setTitle(answer[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]){
        multiStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]){
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
        
    }


