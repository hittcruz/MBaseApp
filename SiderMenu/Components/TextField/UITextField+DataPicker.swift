//
//  UITextField+DataPicker.swift
//  SiderMenu
//
//  Created by Hitver Miguel Cruz Garcia on 13/06/23.
//

import Foundation
import SwiftyGif
import UIKit

var currentTextField: UITextField?
let dateForm: String = "dd/MM/yyyy"
var minDate:Date?
var maxDate: Date?
var itemStartDate: String? = nil
var itemEndDate: String? = nil
var txtFilterFrom: UITextField?
var txtFilterTo: UITextField?

var delegateBegin: txtDeginEditDelegate?

protocol txtDeginEditDelegate: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField)
}

extension UITextField {
    
    //add Datepicker in textField
    
    func addStartDateTextFieldImage() {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        view2.backgroundColor = .white
        view2.clipsToBounds = true
        mainView.addSubview(view2)
        
        let calendar = "calendar.gif"
        var gif:UIImage?
        
        do {
            gif = try UIImage(gifName: calendar)
        } catch {
            print(error)
        }
        
        let imageView = UIImageView(gifImage: gif!, loopCount: 3)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10.0, y: 8.0, width: 30, height: 30)
        
        view2.addSubview(imageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openStartCalendarFromImage))
        view2.addGestureRecognizer(tapGestureRecognizer)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .darkGray
        mainView.addSubview(seperatorView)
        
        seperatorView.frame = CGRect(x: 0, y: 5, width: 0.5, height: 35)
        txtFilterFrom?.rightViewMode = .always
        txtFilterFrom?.rightView = mainView
        
        txtFilterFrom?.layer.borderColor =  UIColor.darkGray.cgColor
        txtFilterFrom?.layer.borderWidth = CGFloat(0.5)
        txtFilterFrom?.layer.cornerRadius = 5
        txtFilterFrom?.font = UIFont.systemFont(ofSize: 12)
        txtFilterFrom?.placeholder = "00/00/0000"
    }
    
    @objc func openStartCalendarFromImage() {
        currentTextField = txtFilterFrom
        txtFilterFrom?.becomeFirstResponder()
        delegateBegin?.textFieldDidBeginEditing(currentTextField!)
    }
    
    func startDatepicker(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleStartDatePicker(sender:)), for: .valueChanged)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateForm
        
        if let selectedDate = txtFilterFrom?.text, selectedDate != "" {
            if let date = dateFormatter.date(from: selectedDate) {
                datePickerView.date = date
            }
        }
        datePickerView.maximumDate = maxDate
    }
    
    @objc func handleStartDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateForm
        txtFilterFrom?.text = dateFormatter.string(from: sender.date)
        itemStartDate = dateFormatter.string(from: sender.date)
        minDate = sender.date
    }
    
    
    func startSetFilterReportToolbarDoneButton(textfield: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(startDoneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textfield.inputAccessoryView = doneToolbar
    }
    
    @objc func startDoneButtonAction() {
        if txtFilterFrom?.text?.isEmpty ?? true {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateForm
            itemStartDate = dateFormatter.string(from: date)
            txtFilterFrom?.text = dateFormatter.string(from: date)
        }
        self.resignFirstResponder()
    }
    
    // End date
    
    func addEndDateTextFieldImage() {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        mainView.layer.cornerRadius = 5
        
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 45))
        view2.backgroundColor = .white
        view2.clipsToBounds = true
        
        mainView.addSubview(view2)
        
        let calendar = "calendar.gif"
        var gif:UIImage?
        
        do {
            gif = try UIImage(gifName: calendar)
        } catch {
            print(error)
        }
        
        let imageView = UIImageView(gifImage: gif!, loopCount: 3)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10.0, y: 8.0, width: 30, height: 30)
        
        view2.addSubview(imageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openEndCalendarFromImage))
        view2.addGestureRecognizer(tapGestureRecognizer)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = .darkGray
        mainView.addSubview(seperatorView)
        
        seperatorView.frame = CGRect(x: 0, y: 5, width: 0.5, height: 35)
        txtFilterTo?.rightViewMode = .always
        txtFilterTo?.rightView = mainView
        
        txtFilterTo?.layer.borderColor =  UIColor.darkGray.cgColor
        txtFilterTo?.layer.borderWidth = CGFloat(0.5)
        txtFilterTo?.layer.cornerRadius = 5
        txtFilterTo?.font = UIFont.systemFont(ofSize: 12)
        txtFilterTo?.placeholder = "00/00/0000"
    }
    
    @objc func openEndCalendarFromImage() {
        currentTextField = txtFilterTo
        txtFilterTo?.becomeFirstResponder()
        delegateBegin?.textFieldDidBeginEditing(currentTextField!)
    }
    
    func endDatepicker(_ sender: UITextField) {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleEndDatePicker(sender:)), for: .valueChanged)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateForm
        
        if let selectedDate = txtFilterTo?.text, selectedDate != "" {
            if let date = dateFormatter.date(from: selectedDate) {
                datePickerView.date = date
            }
        }
        datePickerView.minimumDate = minDate
    }
    
    @objc func handleEndDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateForm
        txtFilterTo?.text = dateFormatter.string(from: sender.date)
        itemEndDate = dateFormatter.string(from: sender.date)
        maxDate = sender.date
    }
    
    func endSetFilterReportToolbarDoneButton(textfield: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endDoneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        textfield.inputAccessoryView = doneToolbar
    }
    
    @objc func endDoneButtonAction() {
        if txtFilterTo?.text?.isEmpty ?? true {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateForm
            itemEndDate = dateFormatter.string(from: date)
            txtFilterTo?.text = dateFormatter.string(from: date)
        }
        txtFilterTo?.resignFirstResponder()
    }
}
