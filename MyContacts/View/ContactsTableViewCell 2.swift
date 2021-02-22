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
    
    override init (style: UITableViewCell.CellStyle , reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let favoriteButton = UIButton(type: .custom)
        favoriteButton.tintColor = .none
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favoriteButton.setImage(UIImage(named: "star"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(selectedFavoriteButton), for: .touchUpOutside)

        accessoryView = favoriteButton
        
    }
    @objc func selectedFavoriteButton(){
        link?.getIndexPath()
//        isFavorite = !isFavorite
//        sender.setImage(isFavorite ? UIImage(named: "star"): UIImage(named: "fullstar"), for: .normal)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

}
