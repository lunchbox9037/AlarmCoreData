//
//  AlarmTableViewCell.swift
//  AlarmCoreData
//
//  Created by stanley phillips on 1/21/21.
//

import UIKit
protocol AlarmTableViewDelegate: AnyObject {
    func alarmWasToggled(_ sender: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmFireDateLabel: UILabel!
    @IBOutlet weak var isEnabledSwitch: UISwitch!
    
    // MARK: - Properties
    weak var delegate: AlarmTableViewDelegate?
    
    // MARK: - Actions
    @IBAction func isEnabledSwitchToggled(_ sender: Any) {
        delegate?.alarmWasToggled(self)
    }
    
    // MARK: - Functions
    func updateViews(alarm: Alarm) {
        alarmTitleLabel.text = alarm.title
        alarmFireDateLabel.text = alarm.fireDate?.stringValue()
        isEnabledSwitch.isOn = alarm.isEnabled
        
    }
}
