//
//  DateFormatter.swift
//  MarsRover
//
//  Created by Vladyslav Dikhtiaruk on 04/09/2024.
//

import Foundation
import SwiftUI


extension DateFormatter {

    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
      
        static let outputFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, yyyy"
            return formatter
        }()
        
        static func date(from string: String) -> Date? {
            return dateFormatter.date(from: string)
        }
        
        static func string(from date: Date) -> String {
            return dateFormatter.string(from: date)
        }
        
        static func formattedDate(from dateString: String) -> String? {
            guard let date = dateFormatter.date(from: dateString) else {
                return nil
            }
            return outputFormatter.string(from: date)
        }
}
