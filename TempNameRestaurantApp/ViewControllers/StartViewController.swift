//
//  ResultViewController.swift
//  TempNameRestaurantApp
//
//  Created by Gavin Sargent on 5/15/23.
//

import UIKit

class StartViewController: UIViewController {
    
    let startButton = StartButton()
    let startTitleLabel = TitleLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        configureStartView()
    }
    
    func configureStartView () {
        view.addSubview(startTitleLabel)
        view.addSubview(startButton)
        
        startButton.addTarget(self, action: #selector(goToMainScreen), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            startTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            startButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    @objc func goToMainScreen () {
        let mainScreen = MainViewController()
        navigationController?.pushViewController(mainScreen, animated: true)
    }
}
