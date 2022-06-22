//
//  ViewController.swift
//  NeoStats
//
//  Created by Sanjeev Mehta on 20/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startDateBtn: UIButton!
    @IBOutlet weak var endDateBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerView: UIView!
    
    //MARK: - Variables
    var dateTag = 0
    var startDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideDatePicker()
    }
    
    //MARK: - Date Picker Hide and show
    func showDatePicker() {
        UIView.animate(withDuration: 0.4) {
            self.datePickerView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    func hideDatePicker() {
        UIView.animate(withDuration: 0.4) {
            self.datePickerView.transform = CGAffineTransform(translationX: 0, y: 1000)
            self.datePickerView.isHidden = false
        }
    }

    //MARK: - Date Formatter
    func dateFormat(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    //MARK: - Buttons Actions
    @IBAction func startDateBtnActn(_ sender: UIButton) {
        dateTag = 0
        showDatePicker()
    }

    @IBAction func endDateBtnActn(_ sender: UIButton) {
        if startDateBtn.currentTitle == "Start Date" {
            self.displayAlert2(title: "Neo Stats", msg: "Please select start date firstly.", ok: "Ok")
            return
        }
        dateTag = 1
        showDatePicker()
    }
    
    @IBAction func submitBtnActn(_ sender: UIButton) {
        self.hapticFeedback(style: .light)
        if startDateBtn.titleLabel?.text == "Start Date" || endDateBtn.titleLabel?.text == "End Date" {
            self.displayAlert2(title: "Neo Stats", msg: "Please select Dates.", ok: "Ok")
         return
        }
        let vc = self.switchController(identifier: "FeedVC") as! FeedVC
        vc.startDate = startDateBtn.currentTitle!
        vc.endDate = endDateBtn.currentTitle!
        self.present(vc, animated: true)
    }
   
    @IBAction func doneBtnActn(_ sender: UIButton) {
        self.hapticFeedback(style: .light)
        if dateTag == 0 {
            self.startDate = datePicker.date
            self.startDateBtn.setTitle(dateFormat(date: datePicker.date), for: .normal)
        } else {
            if !startDate.isGreaterThan(datePicker.date) {
                self.endDateBtn.setTitle(dateFormat(date: datePicker.date), for: .normal)
            } else {
                self.displayAlert2(title: "Neo Stats", msg: "you can not select this date or change the start date.", ok: "Ok")
            }
        }
        hideDatePicker()
    }
    
    @IBAction func cancelBtnActn(_ sender: UIButton) {
        self.hapticFeedback(style: .light)
        hideDatePicker()
    }
    
    
}

