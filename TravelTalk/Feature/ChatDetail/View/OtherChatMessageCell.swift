//
//  OtherChatMessageCell.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//

import UIKit

class OtherChatMessageCell: UITableViewCell {
  
  @IBOutlet weak var uiView: UIView!
  @IBOutlet var profileImageView: UIImageView!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var userMessageLabel: UILabel!
  @IBOutlet var userMessageView: UIView!
  @IBOutlet var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

extension OtherChatMessageCell: TableViewCellBaseConfiguration {
  
  typealias Model = Chat
  
  func configUI(){
    
    self.uiView?.backgroundColor = .clear
    
    /// 프로필 이미지
    self.profileImageView.layer.cornerRadius = profileImageView.frame.width/2
    self.profileImageView.clipsToBounds = true
    self.profileImageView.contentMode = .scaleAspectFill
    
    /// 이름
    self.userNameLabel.font = .systemFont(ofSize: 11, weight: .medium)
    self.userNameLabel.textColor = .black
    
    /// 메시지
    self.userMessageLabel.font = .systemFont(ofSize: 11, weight: .light)
    self.userMessageLabel.textColor = .black
    self.userMessageLabel.numberOfLines = .max
    
    self.userMessageView.layer.backgroundColor = UIColor.white.cgColor
    self.userMessageView.layer.cornerRadius = 6
    self.userMessageView.layer.borderColor = UIColor.darkGray.cgColor
    self.userMessageView.layer.borderWidth = 1
    
    
    /// 날짜
    self.dateLabel.font = .systemFont(ofSize: 8, weight: .heavy)
    self.dateLabel.textColor = .darkGray
    
  }
  
  func setModel(model: Model) {
    profileImageView.image = UIImage(named: model.user.profileImage)
    
    userMessageLabel.text = model.message
    dateLabel.text = model.date.toString(withFormat: .onlyTime)
  }
}
