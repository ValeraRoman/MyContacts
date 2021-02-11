//
//  ContactsTableViewCell.swift
//  MyContacts
//
//  Created by Macbook Air 13 on 10.02.2021.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    var isFavorite = false
    
    var link: ContactsTableViewController?
    
    let favoriteButton = UIButton(type: .custom)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favoriteButton.tintColor = .none
        favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        accessoryView = favoriteButton
        favoriteButton.addTarget(self, action: #selector(selectedFavoriteButton(sender:)), for: .touchUpInside)

    }
    
    @objc func selectedFavoriteButton(sender: UIButton){
        link?.getIndexPath(tableViewCell: self)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
        
}
