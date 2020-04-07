//
//  ViewController.swift
//  CustomEditTextView
//
//  Created by Currie on 4/7/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pencilIcon: UIImageView!
    
    let pencil = UIImage(systemName: "pencil")
    let attachment = NSTextAttachment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }

    func setUp(){
        textView.isScrollEnabled = false
        textView.delegate = self
        attachment.image = pencil
        let attString = NSAttributedString(attachment: attachment)
        textView.textStorage.insert(attString, at: textView.text.count)
        textViewDidChange(textView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.endEditing(true)
    }
}

extension ViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach{ (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.green.cgColor
        textView.layer.cornerRadius = 5
        var text = textView.text
        text!.remove(at: (text?.index(before: text!.endIndex))!)
        textView.text = text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 0
        textView.layer.borderColor = UIColor.clear.cgColor
        let attString = NSAttributedString(attachment: attachment)
        textView.textStorage.insert(attString, at: textView.text.count)
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }
}
