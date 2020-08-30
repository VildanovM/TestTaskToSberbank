//
//  TableViewCell.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Свойства
    var titleName = UILabel()
    static let reusedId = "reusedId"
    // MARK: - Приватные cвойства
    private let icon = UIImageView(image: UIImage(named: "r2d2.png"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleName)
        self.contentView.addSubview(icon)
    }
    
    override func updateConstraints() {
        
        [titleName, icon].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalTo: icon.widthAnchor).isActive = true
        icon.centerYAnchor.constraint(equalTo: titleName.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        icon.trailingAnchor.constraint(equalTo: titleName.leadingAnchor, constant: -30).isActive = true
        titleName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        titleName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        super.updateConstraints()
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
