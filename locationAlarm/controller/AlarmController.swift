//
//  AlarmController.swift
//  locationAlarm
//
//  Created by Kaique Futemma on 23/12/18.
//  Copyright © 2018 Kaique Futemma. All rights reserved.
//

import UIKit

class AlarmController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.white
        navigationItem.title = "Alarms"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(handleSignOut))
    }
    
    @objc func handleSignOut() {
        let guideController = GuideController()
        
        present(guideController, animated: true) {
            UserDefaults.standard.setIsLoggedIn(value: false)
        }
    }
}
