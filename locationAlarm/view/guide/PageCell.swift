//
//  PageCell.swift
//  locationAlarm
//
//  Created by Kaique Futemma on 18/12/18.
//  Copyright © 2018 Kaique Futemma. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            
            guard let page = page else {
                return
            }
            
            imageView.image = UIImage(named: page.imageName)
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [kCTFontAttributeName as NSAttributedString.Key: UIFont.systemFont(ofSize: 20, weight: .regular), kCTForegroundColorAttributeName as NSAttributedString.Key: color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [kCTFontAttributeName as NSAttributedString.Key: UIFont.systemFont(ofSize: 14), kCTForegroundColorAttributeName as NSAttributedString.Key: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
        }
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "kaique.jpg")
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "Teste do textView"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        
        addSubview(textView)
        addSubview(imageView)
        addSubview(lineSeparatorView)
        
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16) .isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16) .isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true
        

        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineSeparatorView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        lineSeparatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        lineSeparatorView.bottomAnchor.constraint(equalTo: textView.topAnchor).isActive = true

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
