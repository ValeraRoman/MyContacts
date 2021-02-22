//
//  ContactsTableViewController.swift
//  MyContacts
//
//  Created by Macbook Air 13 on 10.02.2021.
//

import UIKit
import Contacts

class ContactsTableViewController: UITableViewController {
    
    //MARK: - Property
    
    let identifier = "cell"
    var name = [Names]()
    
    var isShowNumber = false
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getContact()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show number", style: .plain, target: self, action: #selector(showNumber))
        navigationItem.title = "Contacts"
        navigationItem.backButtonTitle = ""
        
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
    
    func getContact(){
        let contactsStore = CNContactStore()
        
        contactsStore.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("Error request ", error )
                return
            }
            if granted {
                let key = [CNContactGivenNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: key as [CNKeyDescriptor])
                var contactForAppend = [Contact]()
                do {
                    try contactsStore.enumerateContacts(with: request, usingBlock: { (contact, finishPointer) in
                        contactForAppend.append(Contact(contact: contact, isFavorite: false))
                    })
                } catch let error  {
                    print("Failed to enumerate contacts", error )
                }
                
                let namesArray = Names(isExpandable: true, names: contactForAppend)
                self.name = [namesArray]
              
            }
        }
        
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
        
        isShowNumber = !isShowNumber
        let animationStyle = isShowNumber ? UITableView.RowAnimation.right : .left
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
        let cell = ContactsTableViewCell(style: .subtitle, reuseIdentifier: identifier)
    
        cell.selectionStyle = .none
        cell.link = self
        let result = name[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = result.contact.givenName
        cell.detailTextLabel?.text = "" 
        if isShowNumber {
            cell.imageView?.image = UIImage(named: "phone")
            cell.detailTextLabel?.text = result.contact.phoneNumbers.first?.value.stringValue
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let closeButton = UIButton()
        closeButton.layer.cornerRadius = 20
        closeButton.backgroundColor = .appLightBlue
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        closeButton.setTitle("Close", for: .normal)
        closeButton.tag = section
        closeButton.addTarget(self, action: #selector(closeSection), for: .touchDown)
        return closeButton
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isShowNumber {
            
        }
        guard let number = name[indexPath.section].names[indexPath.row].contact.phoneNumbers.first?.value.stringValue else {return}
        guard let numberURL = URL(string: "tel://" + number) else {return}
        UIApplication.shared.open(numberURL)
    }
    
}
