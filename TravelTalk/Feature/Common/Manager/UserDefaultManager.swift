//
//  UserDefaultManager.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/15/24.
//

import Foundation

final class UserDefaultManager {
  
  private init() {}
  
  @UserDefaultWrapper(key: Key.채팅방.rawValue, defaultValue: MockChatData.mockChatList)
  static var chatRoomList: [ChatRoom]
}

extension UserDefaultManager {
  /// 키 정의
  enum Key: String {
    case 채팅방
  }
}
