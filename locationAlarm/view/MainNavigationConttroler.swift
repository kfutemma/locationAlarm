//
//  MainNavigationConttroler.swift
//  locationAlarm
//
//  Created by Kaique Futemma on 23/12/18.
//  Copyright © 2018 Kaique Futemma. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn() {
            let alarmController = AlarmController()
            viewControllers = [alarmController]
        } else {
            perform(#selector(showGuideController), with: nil, afterDelay: 0.01)
        }
    }
    
    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    @objc func showGuideController() {
        let guideController = GuideController()
        present(guideController, animated: false, completion: nil)
    }
}
