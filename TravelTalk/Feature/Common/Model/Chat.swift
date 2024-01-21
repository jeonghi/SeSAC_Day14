//
//  Chat.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//

import Foundation

//채팅 화면에서 사용할 데이터 구조체
struct Chat: Codable {
  let user: User
  let date: Date
  let message: String
  
  init(user: User, date: String, message: String) {
    
    self.user = user
    self.date = date.toDate(withFormat: .fullDate) ?? Date()
    self.message = message
  }
}
