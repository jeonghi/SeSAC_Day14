//
//  MeChatMessageCell.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//

import UIKit

class MeChatMessageCell: UITableViewCell {
  
  @IBOutlet weak var uiView: UIView!
  @IBOutlet var userMessageLabel: UILabel!
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet weak var messageBoundView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    configUI()
  }
}

extension MeChatMessageCell: TableViewCellBaseConfiguration {
  
  typealias Model = Chat
  
  func configUI(){
    
    self.uiView.backgroundColor = .clear
    
    self.userMessageLabel.font = .systemFont(ofSize: 11, weight: .light)
    self.userMessageLabel.textColor = .black
    self.userMessageLabel.numberOfLines = .max
    
    self.messageBoundView.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    self.messageBoundView.layer.cornerRadius = 6
    self.messageBoundView.layer.borderWidth = 1
    self.messageBoundView.layer.borderColor = UIColor.gray.cgColor
    
    /// 날짜
    self.dateLabel.font = .systemFont(ofSize: 8, weight: .heavy)
    self.dateLabel.textColor = .darkGray
  }
  
  func setModel(model: Model) {
    userMessageLabel.text = model.message
    dateLabel.text = model.date.toString(withFormat: .onlyTime)
  }
}
