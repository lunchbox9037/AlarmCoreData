//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by stanley phillips on 1/21/21.
//

import UIKit

class AlarmListTableViewController: UITableViewController {    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        cell.updateViews(alarm: AlarmController.shared.alarms[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarmToDelete = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarmToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetailsVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? AlarmDetailTableViewController else {return}
            let alarmToSend = AlarmController.shared.alarms[indexPath.row]
            destination.alarm = alarmToSend
        }
    }
}

// MARK: - Custom cell delegate functions
extension AlarmListTableViewController: AlarmTableViewDelegate {
    func alarmWasToggled(_ sender: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let alarmToToggle = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleIsEnabledFor(alarm: alarmToToggle)
        
    }
}
