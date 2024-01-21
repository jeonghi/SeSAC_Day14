//
//  VCBaseConfiguration.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/20/24.
//

import UIKit

protocol VCBaseConfiguration: AnyObject {
  static var id: String { get }
  func configUI()
}

extension VCBaseConfiguration {
  static var id: String {
    String(describing: self)
  }
}
