//
//  TitleLabel.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/16/23.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitleLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTitleLabel () {
        text = "Restaurant Picker"
        textColor = .white
        backgroundColor = .black
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Times New Roman", size: 40)
    }

}
