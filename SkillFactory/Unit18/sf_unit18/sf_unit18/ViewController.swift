//
//  ViewController.swift
//  sf_unit18
//
//  Created by Иван on 24.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emojiTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? newViewController{
            if segue.identifier == "emoji"{
                destination.emoji = emojiTextField.text ?? "🐈"
                
            }
        }
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }


}

