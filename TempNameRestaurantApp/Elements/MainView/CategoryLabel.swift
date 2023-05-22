//
//  CategoryLabel.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/19/23.
//

import UIKit

class CategoryLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        configureCategoryLabel(title: title)
    }
    func configureCategoryLabel (title: String) {
        text = title
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Times New Roman", size: 22)
    }

}
