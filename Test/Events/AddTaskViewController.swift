//
//  AddTaskViewController.swift
//  Test
//
//  Created by Vineet Rai on 28/02/21.
//

import UIKit
enum TaskType:String {
    case alarm
    case reminder
    case event
}
enum ActionType:String {
    case update
    case new
}
protocol TaskDelegate {
    func reload()
}

class AddTaskViewController: UIViewController,UITextFieldDelegate {
    var delegate: TaskDelegate?
    var category:TaskType = TaskType.reminder //default
    var action:ActionType = ActionType.new //default
    
    @IBOutlet weak var label: UITextField!
    @IBOutlet weak var time: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.delegate = self;
    }
    
    @IBAction func add(_ sender: Any) {
        if !label.hasText {
            let alert = UIAlertController(title: "Opps!", message: "Add Label", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        TaskFunctions.init().addData(label: label.text ?? "", startDate: time.date, endDate: time.date, taskStatus: true, taskType: category.rawValue)
        self.dismiss(animated: true) {
            self.delegate?.reload()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}
