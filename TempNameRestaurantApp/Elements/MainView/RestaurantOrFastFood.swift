//
//  SitOrGoButtons.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/18/23.
//

import UIKit

class RestaurantOrFastFood: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func configureButton(title: String) {
        configuration = .bordered()
//        configuration?.baseBackgroundColor = .systemBlue
        configuration?.baseForegroundColor = .systemBlue
        configuration?.title = title
        configuration?.cornerStyle = .capsule
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    convenience init(title: String) {
        self.init()
        configureButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
