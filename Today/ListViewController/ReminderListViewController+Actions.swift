//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by Anh Tran on 3/14/23.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
    
}
