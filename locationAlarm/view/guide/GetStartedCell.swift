//
//  GetStartedCell.swift
//  locationAlarm
//
//  Created by Kaique Futemma on 23/12/18.
//  Copyright © 2018 Kaique Futemma. All rights reserved.
//

import UIKit

class GetStartedCell: UICollectionViewCell {
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.black
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(handleStarted), for: .touchUpInside)
        
        return button
    }()
    
    weak var delegate: GuideControllerProtocol?
    
    @objc func handleStarted() {
        delegate?.finishSetupGuide()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupComponents()
    }
    
    func setupComponents() {
        self.addSubview(startButton)
        
        startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        startButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
