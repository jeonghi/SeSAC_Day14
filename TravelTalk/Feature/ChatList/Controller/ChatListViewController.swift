//
//  ChatListViewController.swift
//  TravelTalk
//
//  Created by 쩡화니 on 1/14/24.
//
import UIKit

class ChatListViewController: UIViewController {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var searchBar: UISearchBar!
  
  var searchText: String?
  var chatRoomList: [ChatRoom] {
    UserDefaultManager.chatRoomList.filter {
      if let searchText, !searchText.isEmpty {
        $0.chatList.contains(where: {$0.user.rawValue == searchText})
      } else {
        true
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configUI()
  }
  
  // 키보드를 내리는 메서드
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

extension ChatListViewController: VCBaseConfiguration {
  func configUI() {
    configNavbar()
    configSearchBarUI()
    configTableViewUI()
    configTapGesture()
  }
  
  func configSearchBarUI() {
    searchBar.delegate = self
    searchBar.placeholder = "친구 이름을 검색해보세요"
  }
  
  func configTableViewUI(){
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func configNavbar(){
    self.navigationItem.title = "TRAVEL TALK"
  }
  
  /// UITapGestureRecognizer를 생성하고 뷰에 추가.
  func configTapGesture(){
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapGestureRecognizer.delegate = self
    self.view.addGestureRecognizer(tapGestureRecognizer)
  }
}

// MARK: 테이블 뷰
extension ChatListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let idx = indexPath.row
    let chatRoom = chatRoomList[idx]
    
    let xib = UINib(nibName: ChatRoomListCell.id, bundle: nil)
    tableView.register(xib, forCellReuseIdentifier: ChatRoomListCell.id)
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomListCell.id, for: indexPath) as? ChatRoomListCell else {
      return .init()
    }
    
    cell.selectionStyle = .none
    cell.setModel(model: chatRoom)
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    dismissKeyboard()
    let cell = tableView.cellForRow(at: indexPath)
    cell?.backgroundColor = .systemGray
    tableView.reloadRows(at: [indexPath], with: .automatic)
    return indexPath
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let idx = indexPath.row
    let chatRoom = chatRoomList[idx]
    
    let cell = tableView.cellForRow(at: indexPath)
    cell?.backgroundColor = .clear
    tableView.reloadRows(at: [indexPath], with: .automatic)
    
    let sb = UIStoryboard(name: ChatDetailViewController.id, bundle: nil)
    guard let vc = sb.instantiateViewController(withIdentifier: ChatDetailViewController.id) as? ChatDetailViewController else {
      return
    }
    vc.chatRoomId = chatRoom.chatroomId
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    60
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    chatRoomList.count
  }
}

// MARK: 서치바
extension ChatListViewController: UISearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(true, animated: true)
  }
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    true
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchText = searchBar.text
    tableView.reloadData()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.setShowsCancelButton(false, animated: true)
  }
}

// MARK: 탭 제스처
extension ChatListViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    /// 터치 이벤트가 UITableView의 셀에 속할 경우 false를 반환하여 중첩 방지
    if touch.view?.isDescendant(of: tableView) == true {
      return false
    }
    return true
  }
}
