//
//  ViewController.swift
//  Find A Spy
//
//  Created by Иван on 12.07.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerCountTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func startBtnAction(_ sender: Any) {
        let showVC = storyboard?.instantiateViewController(identifier: "ShowVC") as! ShowRoleViewController
        showVC.numberOfPlayers = Int(playerCountTextField.text!) ?? 1
        present(showVC, animated: true)
        
    }
}

