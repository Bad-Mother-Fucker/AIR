//
//  MainTableHeaderView.swift
//  AIR
//
//  Created by alfonso on 28/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class MainTableHeaderView:UIView {
    
    let title = UILabel()
    let icon = UIImageView()
    let button = UIButton()
    var viewController: UIViewController!
    let showsAccessoryButton: Bool!

    let sideEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    let tapRecognizer = UITapGestureRecognizer()
    
    
    init(_ title:String,frame:CGRect,hasAccessoryButton: Bool ){
        showsAccessoryButton = hasAccessoryButton
        super.init(frame:frame)
        self.title.text = title
        //self.viewController = viewController
        switch title{
        case "Recenti":
            self.icon.image = #imageLiteral(resourceName: "cuore")
            break
        case "Avvisi":
            self.icon.image = #imageLiteral(resourceName: "allarme")
            break
        default:
            break
        }
        setView()
        pureLayout()
        setColors()
     
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pureLayout(){
        self.icon.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        self.icon.autoPinEdge(toSuperviewEdge: .left, withInset: 10)
        self.icon.autoSetDimensions(to: CGSize(width: 20, height: 20))
       
        self.title.autoPinEdge(.bottom, to: .bottom, of: icon,withOffset: 2)
        self.title.autoPinEdge(.left, to: .right, of: icon, withOffset: 10)
        self.title.autoSetDimensions(to: CGSize(width: 220, height: 25))
        
        self.button.autoAlignAxis(.horizontal, toSameAxisOf: title)
        self.button.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        self.button.autoSetDimensions(to: CGSize(width: 50, height: 15))
        
        if !showsAccessoryButton {
            button.isHidden = true
        }
    }
    
    
    func setView(){
       
        
        self.title.configureForAutoLayout()
        self.icon.configureForAutoLayout()
        self.button.configureForAutoLayout()
        self.title.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        
        
        self.button.setTitle("altro", for: .normal)
        self.button.setTitleColor(.gray, for: .normal)
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: #selector(mostra))
        button.addGestureRecognizer(tapRecognizer)
        
        
        sideEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        sideEffectView.frame = self.bounds;
        self.addSubview(sideEffectView)
        addSubview(icon)
        addSubview(self.title)
        
        addSubview(self.button)
        
    }
    
    @objc func mostra(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: title.text!), object: nil)
    }
    
    
    
}

extension MainTableHeaderView: DarkModeDelegate{
    
    private func setColors(){
        self.title.textColor = Colors.text
        sideEffectView.isHidden = Bacheca.isDarkModeEnabled ? true:false
        self.backgroundColor = Bacheca.isDarkModeEnabled ? Colors.background : .clear
        
        if !Bacheca.isDarkModeEnabled{
            layer.shadowColor = UIColor.lightGray.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowOffset = CGSize(width: 0.0, height: 8)
            layer.shadowRadius = 2
        }else{
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowOffset = CGSize(width: 0.0, height: 8)
            layer.shadowRadius = 2
        }

    }
    
    func didEnableDarkMode() {
        setColors()
        self.sideEffectView.isHidden = true
    }
    
    func didDisableDarkMode() {
        setColors()
        self.sideEffectView.isHidden = true
    }
 
    
    
}
