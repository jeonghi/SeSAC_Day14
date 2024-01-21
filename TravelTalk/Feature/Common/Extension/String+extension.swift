//
//  String+extension.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/20/24.
//

import Foundation

extension String {
  func toDate(withFormat: DateFormatType) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = withFormat.rawValue
    return dateFormatter.date(from: self)
  }
}

enum DateFormatType: String {
  case fullDate = "yyyy-MM-dd HH:mm"
  case onlyDate = "yy.MM.dd"
  case onlyTime = "hh:mm a"
}
