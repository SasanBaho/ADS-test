//
//  MenuViewController.swift
//  ADS-test
//
//  Created by Sasan Baho on 2020-03-27.
//  Copyright © 2020 Sasan Baho. All rights reserved.
//

import UIKit

class  MenuController: UIView {
    
    var timestamp = Timestamp()
    var newTime = [String : String]()
    var labelTxt : String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        self.addSubview(stack)
        buttonConstraint()
        scrollViewConstraint()
        //Observe the buttons posts
        NotificationCenter.default.addObserver(self, selector: #selector(getNotifi), name: Notification.Name(timestamp.notifiName), object: nil )
    }
    //Do when get notification
    @objc func getNotifi(_ nc: Notification){
        if let data = nc.userInfo as? [String: String]
        {
            labelTxt = data["timestamp"]!
            label.text = (label.text ?? "") + ("\n\(labelTxt!)")
        }
    }
    
    // MARK: - CREATE ELEMENTS
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show time", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    //Button action
    @objc func didTapButton() {
        timestamp = Timestamp()
        newTime = timestamp.generateTime()
        timestamp.timeUpdatePost()
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 50, y: 50, width: 150, height: 50)
        label.numberOfLines = 0;
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stack: UIStackView = {
        //add elements to stackview
        let stack = UIStackView(arrangedSubviews: [button, scrollView])
        stack.alignment = .top
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    //MARK: - CREATE CONSTRAINTS
    
    // constrain the stack
    func stackConstraint(){
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor , constant: 1).isActive = true
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stack.heightAnchor.constraint(equalToConstant: frame.size.height ).isActive = true
        stack.widthAnchor.constraint(equalToConstant: frame.size.width ).isActive = true
    }
    
    // constrain the button
    func buttonConstraint(){
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    // constrain the scroll view
    func scrollViewConstraint(){
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 18.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        // adding label to scroll view
        scrollView.addSubview(label)
        label.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        label.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
}
