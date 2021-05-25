//
//  SideBarViewController.swift
//  SWReveal_practice
//
//  Created by 이병훈 on 2021/05/25.
//

import UIKit

class SideBarViewController: UITableViewController {
    let titles = ["메뉴 01", "메뉴 02", "메뉴 03", "메뉴 04", "메뉴 05"]
    
    let image = [UIImage(named: "icon01"), UIImage(named: "icon02"), UIImage(named: "icon03"), UIImage(named: "icon04"), UIImage(named: "icon05")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 10, y: 30, width: self.view.frame.width / 2, height: 30))
        label.text = "dog10041@naver.com"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(label)
        
        self.tableView.tableHeaderView = v
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.titles.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "menuCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        cell?.textLabel?.text = self.titles[indexPath.row]
        cell?.imageView?.image = self.image[indexPath.row]
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        return cell!
    }
}
