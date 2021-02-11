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
        Names(isExpandable: true, names: [Contact(name: "Robert", number: "+3809923432", isFavorite: false), Contact(name: "Sandra", number: "+3809923432", isFavorite: false),Contact(name: "Oleg", number: "+3809923432", isFavorite: false), Contact(name: "Yura", number: "+3809923432", isFavorite: false), Contact(name: "Sara", number: "+3809923432", isFavorite: false)]),
        Names(isExpandable: true, names: [Contact(name: "Anna", number: "+3809923432", isFavorite: false), Contact(name: "Maria", number: "+3809923432", isFavorite: false),Contact(name: "Oleg", number: "+3809923432", isFavorite: false), Contact(name: "Ivan", number: "+3809923432", isFavorite: false), Contact(name: "Grab", number: "+3809923432", isFavorite: false)]),
        Names(isExpandable: true, names: [Contact(name: "Taras", number: "+3809923432", isFavorite: false), Contact(name: "Jack", number: "+3809923432", isFavorite: false),Contact(name: "Oleg", number: "+3809923432", isFavorite: false), Contact(name: "Hitler", number: "+3809923432", isFavorite: false), Contact(name: "Gringo", number: "+3809923432", isFavorite: false)]),
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
    
    func getIndexPath(tableViewCell: ContactsTableViewCell){
        guard let indexPath = tableView.indexPath(for: tableViewCell) else {return}
        let favoriteName = name[indexPath.section].names[indexPath.row]
        let hasFavorite = favoriteName.isFavorite
        name[indexPath.section].names[indexPath.row].isFavorite = !hasFavorite

        tableViewCell.favoriteButton.setImage( !hasFavorite ? UIImage(named: "fullstar")  : UIImage(named: "star"), for: .normal)
        print(favoriteName)
    }
    
    //MARK: Objc function
    
    @objc func showNumber(){
        var indexPathForReload = [IndexPath]()
        
        for section in name.indices {
            if name[section].isExpandable {
                for row in name[section].names.indices {
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
        for row in name[section].names.indices {
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
        return name[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ContactsTableViewCell
        cell.selectionStyle = .none
        cell.link = self
        let result = name[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = result.name

        if showIndexPath {
            cell.textLabel?.text = "\(result.name) -    \(result.number)"

        }
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
