//
//  ViewController.swift
//  ADS-test
//
//  Created by Sasan Baho on 2020-03-27.
//  Copyright © 2020 Sasan Baho. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    let menu = MenuController()
    var isOpen = false
    var timestamp = Timestamp()
    var newTime = [String : String]()
    var menuWidthAnchor, menuCloseAnchor : NSLayoutConstraint!
    var labelTxt : String!
    let popupWindow = popupView()
    var isPopupOpen = false
    
    @IBOutlet weak var scrollViewTime: UIScrollView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeBtn: UIButton!
    @IBOutlet var menuBottom: UIBarButtonItem!
    @IBOutlet weak var popupUIView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(menu)
        menuConstraint()
        //scale and hide popup view
        popupUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.popupUIView.alpha = 0
        //Observe the buttons posts
        NotificationCenter.default.addObserver(self, selector: #selector(getNotifi), name: Notification.Name(timestamp.notifiName), object: nil )
    }
    //Do when get notification
   @objc func getNotifi(_ nc: Notification){
      if let data = nc.userInfo as? [String: String]
      {
          labelTxt = data["timestamp"]!
          timeLabel.text = (timeLabel.text ?? "") + ("\n\(labelTxt!)")
      }
    }
    
    // add constraint to menu UIView
    func menuConstraint(){
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor).isActive = true
        menu.bottomAnchor.constraint(equalTo:  view.bottomAnchor).isActive = true
        menu.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menu.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        // make it ready for animate
        menu.transform = CGAffineTransform(translationX: -view.frame.size.width/2 , y: 0)
    }
    
    // Menu open and close action
    @IBAction func menuToggle(_ sender: UIBarButtonItem) {
        if isOpen{
            menuBottom.image = UIImage.init(systemName: "line.horizontal.3")
            //animation for menu closing
            UIView.animate(withDuration: 0.5) {
                self.menu.transform = CGAffineTransform(translationX: -self.view.frame.size.width / 2, y: 0)
            }
            isOpen = false
        }else{
            menuBottom.image = UIImage.init(systemName: "multiply")
            //animation for menu opening
            UIView.animate(withDuration: 0.5) {
                self.menu.transform = .identity
            }
            isOpen = true
        }
    }
    // Show timestamp in the label
    @IBAction func timeButton(_ sender: UIButton) {
        timestamp = Timestamp()
        newTime = timestamp.generateTime()
        timestamp.timeUpdatePost()
    }
    //show popup button
    @IBAction func popupShowTimeBtn(_ sender: UIButton) {
        if isPopupOpen {
            //animation for popup closing
            UIView.animate(withDuration: 0.5) {
                self.popupUIView.alpha = 0
                self.popupUIView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            }
            isPopupOpen = false
        }else{
            //animation for popup opening
            UIView.animate(withDuration: 0.5) {
                self.popupUIView.transform = .identity
                self.popupUIView.alpha = 1
            }
            isPopupOpen = true
        }
    }

}

