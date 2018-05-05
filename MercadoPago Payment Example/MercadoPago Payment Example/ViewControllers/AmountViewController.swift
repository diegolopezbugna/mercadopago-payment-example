//
//  AmountViewController.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 03/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

protocol AmountViewControllerDelegate: class {
    func continueButtonPressed(amount: Int?)
}

class AmountViewController: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    var defaultButtonBottomConstraintConstant: CGFloat = 0.0

    @IBAction func continueButtonPressed(_ sender: Any) {
        self.delegate?.continueButtonPressed(amount: self.amount)
    }
    
    weak var delegate: AmountViewControllerDelegate?

    var amount: Int? {
        set {
            self.amountTextField?.text = newValue != nil ? String(newValue!) : nil
        }
        get {
            guard let amount = self.amountTextField?.text else { return nil }
            return Int(amount)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaultButtonBottomConstraintConstant = buttonBottomConstraint.constant
        
        self.title = NSLocalizedString("amountTitle", comment: "")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }

    @objc func keyboardWillHide(notification: Notification) {
        updateBottomLayoutConstraintWithNotification(notification)
    }

    func updateBottomLayoutConstraintWithNotification(_ notification: Notification) {
        // TODO: remove anidated ifs, add guard lets
        let userInfo = notification.userInfo!
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
        if let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
            buttonBottomConstraint.constant = self.defaultButtonBottomConstraintConstant + view.bounds.maxY - convertedKeyboardEndFrame.minY
        }
        if let animationCurveNumber = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
            let rawAnimationCurve = animationCurveNumber << UInt(16)
            let animationCurve = UIViewAnimationOptions(rawValue: rawAnimationCurve)
            if let animationDuration = animationDuration {
                UIView.animate(withDuration: animationDuration, delay: 0, options: [.beginFromCurrentState, animationCurve], animations: {
                    self.view.layoutIfNeeded()  // TODO: odd
                }, completion: nil)
            }
        }
    }
}
