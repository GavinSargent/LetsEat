//
//  ResultInfoLabel.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/23/23.
//

import UIKit

class ResultInfoLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (name:String) {
        self.init(frame: .zero)
        text = name
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Times New Roman", size: 40)
        backgroundColor = .red
    }
    
    convenience init(number:String) {
        self.init(frame: .zero)
        text = number
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont(name: "Times New Roman", size: 30)
        backgroundColor = .blue
    }
}
