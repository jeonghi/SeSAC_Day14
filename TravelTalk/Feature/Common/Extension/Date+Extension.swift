//
//  Date+Extension.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//

import Foundation

extension Date {
  func toString(withFormat format: DateFormatType) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    dateFormatter.locale = Locale(identifier: "ko_KR")
    return dateFormatter.string(from: self)
  }
}
