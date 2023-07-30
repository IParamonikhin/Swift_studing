//
//  ViewController.swift
//  unit26_HW
//
//  Created by Иван on 24.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    let defaultValue = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchBtn.setTitle("", for: .normal)
        switchBtn.layer.cornerRadius = switchBtn.frame.height / 2
        switchBtn.backgroundColor = .yellow
        if defaultValue.string(forKey: "theme") == "day"{

            switchBtn.setImage(UIImage(systemName: "moon"), for: .normal)
            imageView.image = UIImage(named: "day")
            self.view.backgroundColor = UIColor(named: "MyLightBlue")
        } else {
            switchBtn.setImage(UIImage(systemName: "sun.max"), for: .normal)
            imageView.image = UIImage(named: "night")
            self.view.backgroundColor = UIColor(named: "MyDarkBlue")
        }
    
        
    }


    @IBAction func switchBtnAction(_ sender: Any) {
        if defaultValue.string(forKey: "theme") == "day"{
            defaultValue.set("night", forKey: "theme")
            imageView.image = UIImage(named: "night")

            switchBtn.setImage(UIImage(systemName: "sun.max"), for: .normal)
            self.view.backgroundColor = UIColor(named: "MyDarkBlue")
        } else {
            defaultValue.set("day", forKey: "theme")
            switchBtn.setImage(UIImage(systemName: "moon"), for: .normal)
            imageView.image = UIImage(named: "day")
            self.view.backgroundColor = UIColor(named: "MyLightBlue")
        }
        reloadInputViews()
    }
}

