//
//  ChatRoomListCell.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//

import UIKit
import Kingfisher

class ChatRoomListCell: UITableViewCell {
  
  @IBOutlet var profileImage: UIImageView!
  @IBOutlet var title: UILabel!
  @IBOutlet var subTitle: UILabel!
  @IBOutlet var date: UILabel!
  @IBOutlet var uiView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}

extension ChatRoomListCell: TableViewCellBaseConfiguration {
  
  typealias Model = ChatRoom
  
  func configUI() {
    uiView.backgroundColor = .clear
    
    DispatchQueue.main.async {
      self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2 // 원형으로 수정
    }
    profileImage.contentMode = .scaleAspectFill
    profileImage.clipsToBounds = true
    
    title.font = .systemFont(ofSize: 12, weight: .black)
    subTitle.font = .systemFont(ofSize: 11, weight: .light)
    date.font = .systemFont(ofSize: 11, weight: .light)
  }
  
  func setModel(model: Model) {
    profileImage.image = UIImage(named: model.chatroomImage.first!)
    title.text = model.chatroomName
    subTitle.text = model.chatList.last?.message ?? ""
    date.text = model.chatList.last?.date.toString(withFormat: .onlyDate) ?? ""
  }
}
