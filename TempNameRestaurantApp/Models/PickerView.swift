//
//  PickerView.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/16/23.
//

import UIKit

class PickerView: UIPickerView {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(tag: Int) {
        self.init(frame: .zero)
        self.tag = tag
        translatesAutoresizingMaskIntoConstraints = false
    }
}
