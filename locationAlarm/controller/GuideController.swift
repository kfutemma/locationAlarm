//
//  ViewController.swift
//  locationAlarm
//
//  Created by Kaique Futemma on 18/12/18.
//  Copyright © 2018 Kaique Futemma. All rights reserved.
//

import UIKit


protocol GuideControllerProtocol: class {
    func finishSetupGuide()
}

class GuideController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GuideControllerProtocol {
    
    let cellId = "cellId"
    let guideCellId = "guideCellId"
    
    let pages: [Page] = {
        let firstPage = Page(title: "Olá, mundo", message: "Teste de mensagem", imageName: "kaique")
        let secondPage = Page(title: "Meu nome é Kaique", message: "Acabei de me formar", imageName: "kaique")
        let thirdPage = Page(title: "Minha vida", message: "Também fui efetivado!", imageName: "kaique")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .horizontal
       layout.minimumLineSpacing = 0
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       cv.backgroundColor = UIColor.white
       cv.showsHorizontalScrollIndicator = false
       cv.isPagingEnabled = true
       cv.translatesAutoresizingMaskIntoConstraints = false
       cv.dataSource = self
       cv.delegate = self
        
       return cv
    }()
    
    lazy var pageControl: UIPageControl = {
       let pc = UIPageControl()
       pc.pageIndicatorTintColor = UIColor.lightGray
       pc.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
       pc.numberOfPages = self.pages.count + 1
       pc.translatesAutoresizingMaskIntoConstraints = false
        
       return pc
    }()
    
    lazy var skipButton: UIButton = {
       let button = UIButton(type: .system)
       button.setTitle("Skip", for: .normal)
       button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
       button.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
       button.translatesAutoresizingMaskIntoConstraints = false
        
       return button
    }()
    
    @objc func skipPage() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc func nextPage() {
        
        if pageControl.currentPage == pages.count {
            return
        }
        
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCell()
        self.navigationController?.isNavigationBarHidden = true
        self.setupInputComponents()

    }
    
    private func registerCell() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(GetStartedCell.self, forCellWithReuseIdentifier: guideCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let getStartedCell = collectionView.dequeueReusableCell(withReuseIdentifier: guideCellId, for: indexPath) as! GetStartedCell
            
            getStartedCell.delegate = self
            
            return getStartedCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    func finishSetupGuide() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [AlarmController()]
        
        UserDefaults.standard.setIsLoggedIn(value: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pages.count {
            moveControlConstraintsOffScreen()
        } else {
            pageControllBottomAnchor?.constant = 0
            pageControllNextAnchor?.constant = 16
            pageControllSkipAnchor?.constant = 16
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func moveControlConstraintsOffScreen() {
        pageControllBottomAnchor?.constant = 40
        pageControllNextAnchor?.constant = -40
        pageControllSkipAnchor?.constant = -40
    }
    
    var pageControllBottomAnchor: NSLayoutConstraint?
    var pageControllSkipAnchor: NSLayoutConstraint?
    var pageControllNextAnchor: NSLayoutConstraint?
    
    func setupInputComponents() {
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        pageControllBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        pageControllBottomAnchor?.isActive = true
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        pageControllSkipAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        pageControllSkipAnchor?.isActive = true
        skipButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
        pageControllNextAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        pageControllNextAnchor?.isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
}

