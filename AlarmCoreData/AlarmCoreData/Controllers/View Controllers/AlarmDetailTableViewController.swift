//
//  AlarmDetailTableViewController.swift
//  AlarmCoreData
//
//  Created by stanley phillips on 1/21/21.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var alarmFireDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var alarmIsEnabledButton: UIButton!
    
    // MARK: - Properties
    var alarm: Alarm?
    var isAlarmOn: Bool = true
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func alarmIsEnabledButtonTapped(_ sender: Any) {
        if let alarm = alarm {
            AlarmController.shared.toggleIsEnabledFor(alarm: alarm)
        } else {
            isAlarmOn.toggle()
        }
        designIsEnabledButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let alarmTitle = alarmTitleTextField.text, !alarmTitle.isEmpty else {return}
        let fireDate = alarmFireDatePicker.date
            
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, newTitle: alarmTitle, newFireDate: fireDate, isEnabled: isAlarmOn)
        } else {
            AlarmController.shared.createAlarmWith(title: alarmTitle, fireDate: fireDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods
    func updateViews() {
        guard let alarmDetails = alarm else {return}
        alarmTitleTextField.text = alarmDetails.title
        alarmFireDatePicker.date = alarmDetails.fireDate ?? Date()
        isAlarmOn = alarmDetails.isEnabled
        designIsEnabledButton()
    }
    
    func designIsEnabledButton() {
        switch isAlarmOn {
        case true:
            alarmIsEnabledButton.backgroundColor = .white
            alarmIsEnabledButton.setTitle("Enabled", for: .normal)
        case false:
            alarmIsEnabledButton.backgroundColor = .darkGray
            alarmIsEnabledButton.setTitle("Disabled", for: .normal)
        }
    }
}
