//
//  TakeMeThereButton.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/23/23.
//

import UIKit

class TakeMeThereButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureTakeMeThereButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTakeMeThereButton(){
        configuration = .tinted()
        configuration?.baseBackgroundColor = .systemBlue
        configuration?.baseForegroundColor = .systemBlue
        configuration?.title = "Take Me There"
        configuration?.cornerStyle = .capsule
        configuration?.buttonSize = .large
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
