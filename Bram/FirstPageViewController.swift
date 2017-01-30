//
//  FirstPageViewController.swift
//  Bram
//
//  Created by Gabriel Gheorghian on 2017-01-27.
//  Copyright © 2017 GabrielGhe. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavigationBar()
        createOverlay()
        createAddCardView()
    }
    
    func styleNavigationBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
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
