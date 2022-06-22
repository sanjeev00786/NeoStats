//
//  extensions.swift
//  ProspectApp
//
//  Created by SANJEEV on 06/09/21.
//

import UIKit

extension UIViewController{
    
    //Default Alert Box
    func displayAlert( title:String,msg: String?, ok: String, okAction: (() -> Void)? = nil){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: ok, style: .default)
        { (action) in
            if let okAction = okAction {
                DispatchQueue.main.async(execute: {
                    okAction()
                })
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        { (action) in
           // alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func displayAlert2( title:String,msg: String?, ok: String, okAction: (() -> Void)? = nil){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: ok, style: .default)
        { (action) in
            if let okAction = okAction {
                DispatchQueue.main.async(execute: {
                    okAction()
                })
            }
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    //MARK:- Switch Controller
    func switchController(identifier: String) -> UIViewController{
        let vc = self.storyboard!.instantiateViewController(identifier: identifier)
        return vc
    }

    func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle)  {
        
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
}

extension Date {

  func isEqualTo(_ date: Date) -> Bool {
    return self == date
  }
  
  func isGreaterThan(_ date: Date) -> Bool {
     return self > date
  }
  
  func isSmallerThan(_ date: Date) -> Bool {
     return self < date
  }
}


