//
//  ContactsTableViewController.swift
//  MyContacts
//
//  Created by Macbook Air 13 on 10.02.2021.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    //MARK: - Property
    
    let identifier = "cell"
    var name = [
        Names(isExpandable: true, name: ["Robert", "Sandra", "Yura", "Oleg", "Sara"]),
        Names(isExpandable: true, name: ["Anna", "Maria", "Grab", "Ivan"]),
        Names(isExpandable: true, name:  ["Taras", "Jack", "Gringo", "Hitler"])
    ]
    
    var showIndexPath = false
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show number", style: .plain, target: self, action: #selector(showNumber))
        navigationItem.title = "Contacts"
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    
    //MARK: Functions
    
    func getIndexPath(tableViewCell: UITableViewCell){
        let indexPath = tableView.indexPath(for: tableView)
        print(indexPath)
    }
    
    //MARK: Objc function
    
    @objc func showNumber(){
        var indexPathForReload = [IndexPath]()
        
        for section in name.indices {
            if name[section].isExpandable {
                for row in name[section].name.indices {
                    let indexPath = IndexPath(row: row, section: section)
                    indexPathForReload.append(indexPath)
                }
            }
        }
        
        showIndexPath = !showIndexPath
        let animationStyle = showIndexPath ? UITableView.RowAnimation.right : .left
        self.tableView.reloadRows(at: indexPathForReload, with: animationStyle)
    }
    
    @objc func closeSection(sender: UIButton) {
        let section = sender.tag
        var indexPathForClose = [IndexPath]()
        for row in name[section].name.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPathForClose.append(indexPath)
        }
        let expandable = name[section].isExpandable
        name[section].isExpandable = !expandable
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        sender.setTitle(expandable ? "Open" : "Close", for: .normal)
        if expandable {
            tableView.deleteRows(at: indexPathForClose, with: .fade)
        } else {
            tableView.insertRows(at: indexPathForClose, with: .fade)
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return name.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !name[section].isExpandable {
            return 0
        }
        return name[section].name.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactsTableViewCell
        cell.selectionStyle = .none
        cell.link = self
        cell.textLabel?.text = name[indexPath.section].name[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let closeButton = UIButton()
        closeButton.backgroundColor = .green
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        closeButton.setTitle("Close", for: .normal)
        closeButton.tag = section
        closeButton.addTarget(self, action: #selector(closeSection), for: .touchDown)
        return closeButton
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
