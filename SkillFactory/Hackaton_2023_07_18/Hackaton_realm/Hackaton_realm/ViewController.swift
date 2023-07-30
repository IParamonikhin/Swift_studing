//
//  ViewController.swift
//  Hackaton_realm
//
//  Created by Иван on 23.07.2023.
//

import UIKit
import RealmSwift

enum BalanceAction{
    case withdrawal
    case refillDeposit
    case refillMobile
    case none
}

struct Action{
    var timeAndDate: String = ""
    var operation: String = ""
    var target: String = ""
    var sum: Float = 0.0
    var type: String = ""
}

protocol ActionDelegate: class{
    func withdrawalCallback(_ sum: Float, _ date: String)
    func refillCallback(_ sum: Float, _ date: String)
    func refillMobileCallback(_ sum: Float, _ date: String, _ number: String)
}

class ViewController: UIViewController {

    @IBOutlet weak var mobileRefileBtn: UIButton!
    @IBOutlet weak var refillBtn: UIButton!
    @IBOutlet weak var withdrawalBtn: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var action: [Action]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        var balance = realm.objects(Balance.self)
        if balance.count == 0{
            var newBalance = Balance()
            newBalance.balance = 1000000.0
            try! realm.write{
                realm.add(newBalance)
            }
        }
        balance = realm.objects(Balance.self)
        balanceLabel.text = String(balance.first!.balance)
        tableView.delegate = self
        tableView.dataSource = self
        

    
    }
    
    @IBAction func withdrawalBtnAction(_ sender: Any) {
        showActionVC(.withdrawal)
    }
    @IBAction func refillDepositBtnAction(_ sender: Any) {
        showActionVC(.refillDeposit)
    }
    @IBAction func refillMobileBtnAction(_ sender: Any) {
        showActionVC(.refillMobile)
    }
    
    private func updateBalance(_ sum : Float, _ action : BalanceAction){
        let realm = try! Realm()
        var updatedBalance = realm.objects(Balance.self)
        var result = updatedBalance.first!.balance
        switch action{
        case .withdrawal:
            result -= sum
        case .refillDeposit:
            result += sum
        case .refillMobile:
            result -= sum
        case .none:
            break
        }
        try! realm.write{
            updatedBalance.first!.balance = result
        }
        updatedBalance = realm.objects(Balance.self)
        let temp = updatedBalance.first!.balance
        balanceLabel.text = String(temp)
    }
    
    private func showActionVC(_ actionType: BalanceAction){
        let showVC = storyboard?.instantiateViewController(identifier: "ActionVC") as! ActionViewController
//        if let sheet = showVC.sheetPresentationController{ sheet.detents = [.medium()]}
        let realm = try! Realm()
        let balance = realm.objects(Balance.self)
        showVC.actualBalance = balance.first!.balance
        showVC.actionType = actionType
        showVC.actionCallback = self
        present(showVC, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       let realm = try! Realm()
       let model = realm.objects(Model.self)
       return model.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
       
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return UITableViewCell() }
       cell.selectionStyle = .none
       let realm = try! Realm()
       let model = realm.objects(Model.self)
       let index = model.count - indexPath.row - 1
       cell.sumLabel.text = String((model[index].value(forKey: "sum") as! Float))
       cell.targetLabel.text = (model[index].value(forKey: "target") as! String)
       if model[index].value(forKey: "operation") as! String == "refill"{
           cell.imageArrow.image = UIImage(systemName: "arrow.up")
           cell.imageArrow.tintColor = .green
       } else {
           cell.imageArrow.image = UIImage(systemName: "arrow.down")
           cell.imageArrow.tintColor = .red
       }
       cell.backgroundColor = .clear
       cell.layer.borderColor = UIColor(named: "font_color")?.cgColor
       cell.layer.borderWidth = 2

       return cell

   }
}


extension ViewController: ActionDelegate{

    func withdrawalCallback(_ sum: Float, _ date: String) {
        let realm = try! Realm()
        let tempModel = Model()
        tempModel.operation = "withdrawal"
        tempModel.timeAndDate = date
        tempModel.target = "deposit"
        tempModel.sum = sum
        tempModel.type = "type"
        try! realm.write{
            realm.add(tempModel)
        }
        updateBalance(sum, .withdrawal)
        tableView.reloadData()
    }

    func refillCallback(_ sum: Float, _ date: String) {
        let realm = try! Realm()
        let tempModel = Model()
        tempModel.operation = "refill"
        tempModel.timeAndDate = date
        tempModel.target = "deposit"
        tempModel.sum = sum
        tempModel.type = "type"
        try! realm.write{
            realm.add(tempModel)
        }
        updateBalance(sum, .refillDeposit)
        tableView.reloadData()
    }

    func refillMobileCallback(_ sum: Float, _ date: String, _ number: String) {
        let realm = try! Realm()
        let tempModel = Model()
        tempModel.operation = "refillMobile"
        tempModel.timeAndDate = date
        tempModel.target = number
        tempModel.sum = sum
        tempModel.type = "type"
        try! realm.write{
            realm.add(tempModel)
        }
        updateBalance(sum, .refillMobile)
        tableView.reloadData()
    }


}


extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
