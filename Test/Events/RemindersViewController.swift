//
//  RemindersViewController.swift
//  Test
//
//  Created by Vineet Rai on 27/02/21.
//

import UIKit

class RemindersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,TaskDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var reminderData:[Task] = Array<Task>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reload()
    }
    
    func reload (){
        reminderData = TaskFunctions.init().fetchData(taskType: TaskType.reminder.rawValue)
        tableView.reloadData()
    }
    
    func uiSetup(){
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderData.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ReminderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderTableViewCell
        cell.label.text = reminderData[indexPath.row].label
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy, h:mm a"
        let dateTime = dateFormater.string(from: reminderData[indexPath.row].startDate!).components(separatedBy: ", ")
        cell.date.text = dateTime[0]
        cell.time.text = dateTime[1]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let task = reminderData[indexPath.row]
            TaskFunctions.init().deleteData(task: task)
            reminderData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func add(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc:AddTaskViewController = storyboard.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        vc.category = TaskType.reminder
        vc.action = ActionType.new
        vc.delegate = self;
        self.present(vc, animated: true)
        
    }
    
}
