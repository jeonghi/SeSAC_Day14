//
//  CellBaseConfiguration.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/20/24.
//

import UIKit

protocol TableViewCellBaseConfiguration {
  associatedtype Model
  static var id: String { get }
  func configUI()
  func setModel(model: Model)
}

extension TableViewCellBaseConfiguration {
  static var id: String {
    String(describing: self)
  }
  func setModel(model: Model) {}
}
