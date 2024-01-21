//
//  ChatDetailViewController.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//

import UIKit

class ChatDetailViewController: UIViewController {
  
  @IBOutlet weak var sendViewBottomMargin: NSLayoutConstraint!
  @IBOutlet weak var senderButton: UIButton!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var textInputView: UIView!
  var chatRoomId: Int?
  @IBOutlet var tableView: UITableView!
  
  var chatRoom: ChatRoom? {
    UserDefaultManager.chatRoomList.first{$0.chatroomId == self.chatRoomId}
  }
  
  var chatRoomName: String {
    chatRoom?.chatroomName ?? ""
  }
  
  var chatList: [Chat] {
    chatRoom?.chatList ?? []
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
    configTableView()
    scrollTableViewToLast()
  }
}

extension ChatDetailViewController: VCBaseConfiguration {
  func configUI() {
    configNavbar()
    configTextInputView()
    configTableView()
  }
  
  func configNavbar(){
    self.navigationItem.title = chatRoomName
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  func configTextInputView(){
    self.textView.delegate = self
    textInputView.backgroundColor = .systemGray2.withAlphaComponent(0.2)
    textInputView.layer.borderColor = .none
    textInputView.layer.cornerRadius = 6
    senderButton.addTarget(self, action: #selector(tappedSendChatButton), for: .touchUpInside)
  }
  
  @objc func tappedSendChatButton(_ sender: UIButton){
    
  }
  
  func configTableView(){
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = 80
    self.tableView.separatorStyle = .none
  }
}

extension ChatDetailViewController {
  func initNotification() {
    // 키보드 올라올 때
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    /// 키보드 내려갈 때
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  /// 키보드 올라오기
  @objc func keyboardWillShow(noti: Notification) {
    let notiInfo = noti.userInfo!
    /// 키보드 높이를 가져옴
    let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
    sendViewBottomMargin.constant = height
    
    /// 애니메이션 효과를 키보드 애니메이션 시간과 동일하게
    let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    UIView.animate(withDuration: animationDuration) {
      self.view.layoutIfNeeded()
    }
  }
  
  /// 키보드 내려가기
  @objc func keyboardWillHide(noti: Notification) {
    let notiInfo = noti.userInfo!
    let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    self.sendViewBottomMargin.constant = 0
    
    // 애니메이션 효과를 키보드 애니메이션 시간과 동일하게
    UIView.animate(withDuration: animationDuration) {
      self.view.layoutIfNeeded()
    }
  }
}

extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.estimatedRowHeight
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    chatList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let idx = indexPath.row
    let chat = chatList[idx]
    
    if chat.user == .user {
      let xib = UINib(nibName: MeChatMessageCell.id, bundle: nil)
      tableView.register(xib, forCellReuseIdentifier: MeChatMessageCell.id)
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MeChatMessageCell.id) as? MeChatMessageCell else {
        return .init()
      }
      cell.setModel(model: chat)
      cell.selectionStyle = .none
      return cell
    } else {
      let xib = UINib(nibName: OtherChatMessageCell.id, bundle: nil)
      tableView.register(xib, forCellReuseIdentifier: OtherChatMessageCell.id)
      guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherChatMessageCell.id) as? OtherChatMessageCell else {
        return .init()
      }
      cell.setModel(model: chat)
      cell.selectionStyle = .none
      return cell
    }
  }
  
  /// 테이블 뷰를 가장 하단으로 스크롤
  func scrollTableViewToLast(){
    let lastSection = tableView.numberOfSections - 1
    let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
    let indexPath = IndexPath(row: lastRow, section: lastSection)
    tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
  }
}

extension ChatDetailViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.becomeFirstResponder() // 키보드를 표시
  }
  func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
    textView.resignFirstResponder() // 키보드를 숨김
    return true
  }
}
