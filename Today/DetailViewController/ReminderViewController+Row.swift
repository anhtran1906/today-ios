//
//  ReminderViewController+Row.swift
//  Today
//
//  Created by Anh Tran on 3/14/23.
//

import UIKit

extension ReminderViewController {
    enum Row: Hashable {
        case header(String)
        case date
        case notes
        case time
        case title
        var imageName: String? {
            switch self {
            case .date: return "calendar"
            case .notes: return "list.bullet.clipboard"
            case .time: return "clock"
            default: return nil
            }
        }
        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }
        
        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
   
}

