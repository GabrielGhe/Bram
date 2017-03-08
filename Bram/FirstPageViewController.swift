//
//  FirstPageViewController.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-27.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit
import FontAwesome_swift

class FirstPageViewController: UIViewController, UITextViewDelegate {
    
    private var scrollView: UIScrollView?
    private var frontCard: UITextView?
    private var backCard: UITextView?
    private let PLACEHOLDER = "Type here"
    private let SIDE_DISTANCE = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigationBar()
        addScrollView()
        //createOverlay()
        //createAddCardView()
        createAddCardViewUgly()
        createAddButtonView()
    }
    
    // MARK: - Initialization
    
    func styleNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        addNavigationBarButtons()
    }
    
    // MARK: - NavigationBar
    
    func addNavigationBarButtons() {
        let showBrowseButton = UIBarButtonItem(
            title: String.fontAwesomeIcon(name: FontAwesome.search),
            style: .plain,
            target: self,
            action: #selector(showBrowse))
        showBrowseButton.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.fontAwesome(ofSize: 25)],
            for: .normal)
        self.navigationItem.rightBarButtonItem  = showBrowseButton
        
        let showQuizButton = UIBarButtonItem(
            title: String.fontAwesomeIcon(name: FontAwesome.star),
            style: .plain,
            target: self,
            action: #selector(showQuiz))
        showQuizButton.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.fontAwesome(ofSize: 25)],
            for: .normal)
        self.navigationItem.leftBarButtonItem  = showQuizButton
    }
    
    func showBrowse() {
        let browseViewController = BrowseViewController()
        self.navigationController?.pushViewController(browseViewController, animated: true)
    }
    
    func showQuiz() {
        
    }
    
    func addScrollView() {
        self.scrollView = UIScrollView()
        self.view.addSubview(scrollView!)
        self.scrollView!.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(self.view)
            make.top.equalTo(self.view)
        }
        self.scrollView?.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func createAddCardViewUgly() {
        self.frontCard = UITextView()
        self.backCard = UITextView()
        let grayBar = UIView()
        
        guard let frontCard = frontCard, let backCard = backCard, let scrollView = scrollView else {
            return
        }
        
        frontCard.delegate = self
        backCard.delegate = self
        
        scrollView.addSubview(frontCard)
        scrollView.addSubview(grayBar)
        scrollView.addSubview(backCard)
        
        
        frontCard.text = PLACEHOLDER
        frontCard.textColor = UIColor.lightGray
        
        grayBar.backgroundColor = UIColor.lightGray
        
        backCard.text = PLACEHOLDER
        backCard.textColor = UIColor.lightGray
        
        let cardHeight = 150
        
        frontCard.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(frontCard.superview!).offset(SIDE_DISTANCE)
            make.left.equalTo(self.view).offset(SIDE_DISTANCE)
            make.right.equalTo(self.view).offset(-SIDE_DISTANCE)
            make.height.equalTo(cardHeight)
        }
        
        grayBar.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(frontCard.snp.bottom).offset(SIDE_DISTANCE*3)
            make.left.equalTo(self.view).offset(SIDE_DISTANCE*3)
            make.right.equalTo(self.view).offset(-SIDE_DISTANCE*3)
            make.height.equalTo(1)
        }
        
        backCard.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(grayBar.snp.bottom).offset(SIDE_DISTANCE*3)
            make.left.equalTo(self.view).offset(SIDE_DISTANCE)
            make.right.equalTo(self.view).offset(-SIDE_DISTANCE)
            make.height.equalTo(cardHeight)
        }
    }
    
    func createOverlay() {
        let overlay: UIView = UIView()
        
        guard let navView = self.navigationController!.view else {
            return
        }
        self.navigationController?.view.addSubview(overlay)
        overlay.backgroundColor = UIColor.black
        overlay.layer.opacity = 0.5
        overlay.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(navView)
            make.top.equalTo(navView)
            make.left.equalTo(navView)
            make.right.equalTo(navView)
            make.height.equalTo(navView)
        }
    }
    
    func createAddCardView() {
        let overlay: UIView = UIView()
        overlay.layer.cornerRadius = 20
        
        guard let navView = self.navigationController!.view else {
            return
        }
        self.navigationController?.view.addSubview(overlay)
        overlay.backgroundColor = UIColor.white
        overlay.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(navView)
            make.top.equalTo(navView).offset(60)
            make.left.equalTo(navView).offset(1)
            make.right.equalTo(navView).offset(-1)
            make.height.equalTo(navView)
        }
        
        overlay.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(navView)
            make.top.equalTo(navView).offset(60)
            make.left.equalTo(navView).offset(1)
            make.right.equalTo(navView).offset(-1)
            make.height.equalTo(navView)
        }
    }
    
    // MARK: - UITextView
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        setPlaceholder(textView: textView)
    }
    
    // MARK: - AddButton
    
    func createAddButtonView() {
        let addButton = UIButton(type: .roundedRect)
        guard let scrollView = self.scrollView, let backCard = self.backCard else {
            return
        }
        
        scrollView.addSubview(addButton)
        addButton.setTitle("Add",for: .normal)
        addButton.titleLabel?.textColor = .black
        
        addButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(backCard.snp.bottom).offset(SIDE_DISTANCE*3)
            make.left.equalTo(self.view).offset(SIDE_DISTANCE)
            make.right.equalTo(self.view).offset(-SIDE_DISTANCE)
            make.height.equalTo(30)
        }
        
        addButton.addTarget(self, action: #selector(addClicked), for: .touchUpInside)
    }
    
    func addClicked() {
        guard let frontCard = self.frontCard, let backCard = self.backCard else {
            return
        }
        
        if frontCard.text.isEmpty || backCard.text.isEmpty {
            return
        }
        
        guard let question = frontCard.text, let answer = backCard.text else {
            return
        }
        
        let card = CardBuilder()
            .set(question: question)
            .set(answer: answer)
            .build()
        
        BramStorage.sharedInstance.save(card: card)
        
        frontCard.text = ""
        backCard.text = ""
        frontCard.resignFirstResponder()
        backCard.resignFirstResponder()
        setPlaceholder(textView: frontCard)
        setPlaceholder(textView: backCard)
        
        scrollView?.scrollToTop()
    }
    
    func setPlaceholder(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = PLACEHOLDER
            textView.textColor = UIColor.lightGray
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
