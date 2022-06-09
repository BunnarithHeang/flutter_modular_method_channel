//
//  ViewController.swift
//  ios_module
//
//  Created by bunnarith.heang on 5/6/22.
//

import UIKit
import Flutter

class ViewController: UIViewController {
    var openedWithArgs: Bool?
    var backedWithArgs: Bool?
    
    lazy var label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonWidth = 150.0
        let buttonHeight = 40.0
        let x = self.view.center.x
        let y = self.view.center.y
        
        let woButton = UIButton(type: UIButton.ButtonType.custom)
        woButton.addTarget(self, action: #selector(showWithoutArgs), for: .touchUpInside)
        woButton.setTitle("Without Args", for: UIControl.State.normal)
        woButton.frame = CGRect(
            x: x - buttonWidth,
            y: y - (buttonHeight / 2),
            width: buttonWidth,
            height: buttonHeight)
        woButton.setTitleColor(UIColor.tintColor, for: .normal)
        
        let wButton = UIButton(type: UIButton.ButtonType.custom)
        wButton.addTarget(self, action: #selector(showWithArgs), for: .touchUpInside)
        wButton.setTitle("With Args", for: UIControl.State.normal)
        wButton.frame = CGRect(
            x: x,
            y: y - (buttonHeight / 2),
            width: buttonWidth,
            height: buttonHeight)
        wButton.setTitleColor(UIColor.tintColor, for: .normal)
        
        label.center = CGPoint(x: x, y: y + buttonHeight * 1.2)
        label.textAlignment = .center

        self.view.addSubview(label)
        self.view.addSubview(woButton)
        self.view.addSubview(wButton)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.onGetArgsValue = onGetArgsValue
        appDelegate.onSetArgsValue = onSetArgsValue
    }
    
    private func onGetArgsValue() -> Bool {
        return openedWithArgs ?? false
    }
    
    private func onSetArgsValue(val: Bool) {
        self.backedWithArgs = val

        if (self.backedWithArgs != nil) {
            self.label.text = "Backed With Arguments: \(self.backedWithArgs ?? true)"
        } else {
            self.label.text = "Backed With Arguments: NULL VALUE"
        }
    }
    
    @objc func showWithoutArgs() {
        presentFlutterVCWith(args: false)
    }
    
    @objc func showWithArgs() {
        presentFlutterVCWith(args: true)
    }
    
    func presentFlutterVCWith(args: Bool) {
        openedWithArgs = args;

        let fvc = (UIApplication.shared.delegate as! AppDelegate).flutterViewController
        present(fvc!, animated: true, completion: nil)
    }
}

