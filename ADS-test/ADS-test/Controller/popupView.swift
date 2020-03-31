//
//  popupView.swift
//  ADS-test
//
//  Created by Sasan Baho on 2020-03-30.
//  Copyright © 2020 Sasan Baho. All rights reserved.
//

import UIKit

class popupView: UIView {
    var timestamp = Timestamp()
    var newTime = [String : String]()
    var labelTxt : String!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addObserver()
        commonInit()
    }

    required init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        addObserver()
        commonInit()
    }
    
    //Observe the buttons posts
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(getNotifi), name: Notification.Name(timestamp.notifiName), object: nil )
    }
    //Do when get notification
    @objc func getNotifi(_ nc: Notification){
       if let data = nc.userInfo as? [String: String]
       {
           labelTxt = data["timestamp"]!
           mainLabel.text = (mainLabel.text ?? "") + ("\n\(labelTxt!)")
       }
     }
    
    //Initializ popup xib
    func commonInit(){
        Bundle.main.loadNibNamed("PopupView", owner: self, options:nil)
        //add xib to view
        addSubview(contentView)
        contentView.frame = (self.bounds)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func showTimeBtn(_ sender: UIButton) {
        timestamp = Timestamp()
        newTime = timestamp.generateTime()
        timestamp.timeUpdatePost()
    }
}
