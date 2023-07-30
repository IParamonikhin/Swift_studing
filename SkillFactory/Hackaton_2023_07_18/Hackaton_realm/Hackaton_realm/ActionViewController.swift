//
//  ActionViewController.swift
//  Hackaton_realm
//
//  Created by Иван on 23.07.2023.
//

import UIKit

class ActionViewController: UIViewController {

    var localWithdrawalView : withdrawalView?
    var localRefillView : refillCashView?
    var localMobileRefillView : mobileRefillView?
    var actionType : BalanceAction = .none
    var actualBalance : Float = 0.0
    
    weak var actionCallback: ActionDelegate?
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var acceptBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        switch self.actionType {
        case .withdrawal:
            localWithdrawalView = withdrawalView(frame: CGRectMake(0, 130, 361, 50))
            customView.addSubview(localWithdrawalView!)
        case .refillDeposit:
            localRefillView = refillCashView(frame: CGRectMake(0, 130, 361, 50))
            customView.addSubview(localRefillView!)
        case .refillMobile:
            localMobileRefillView = mobileRefillView(frame: CGRectMake(0, 100, 361, 150))
            customView.addSubview(localMobileRefillView!)
        case .none:
            dismiss(animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func showAlert(){
        let alert = UIAlertController(title: "Ошибка", message: "Недостаточно денег!", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .default)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @IBAction func acceptBtnAction(_ sender: Any) {
        switch self.actionType {
        case .withdrawal:
            
            var sum = (localWithdrawalView?.countTextField.text)!
            let date = Date()
            let dateFormatter = DateFormatter()
            sum.replace(",", with: ".")
            if actualBalance >= Float(sum)!{
                actionCallback?.withdrawalCallback(Float(sum)!.rounded(toPlaces: 2) , dateFormatter.string(from: date))
            } else {
                showAlert()
            }
        case .refillDeposit:
            var sum = (localRefillView?.countTextField.text)!
            let date = Date()
            let dateFormatter = DateFormatter()
            sum.replace(",", with: ".")
            actionCallback?.refillCallback(Float(sum)!.rounded(toPlaces: 2) , dateFormatter.string(from: date))
        case .refillMobile:
            var sum = (localMobileRefillView?.countTextField.text)!
            let date = Date()
            let dateFormatter = DateFormatter()
            let number = (localMobileRefillView?.mobileTextField.text)!
            sum.replace(",", with: ".")
            if actualBalance >= Float(sum)!{
                actionCallback?.refillMobileCallback(Float(sum)!.rounded(toPlaces: 2) , dateFormatter.string(from: date), number)
            } else {
                showAlert()
            }
        case .none:
            dismiss(animated: true)
        }
        dismiss(animated: true)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
