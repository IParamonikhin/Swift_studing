//
//  withdrawalView.swift
//  Hackaton_realm
//
//  Created by Иван on 23.07.2023.
//

import UIKit

class withdrawalView: UIView {
    
    @IBOutlet weak var countTextField: UITextField!
    
    var workingView: UIView!
    var xibName: String = "withdrawalCashView"
    
    func getText() -> String{
        guard let text = self.countTextField!.text else { return "error" }
        return  text
    }
    
    func getFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib (nibName: xibName, bundle: bundle)
        let view = xib.instantiate (withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func setCustomView() {
        workingView = getFromXib()
        workingView.frame = bounds
        workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview (workingView)
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init (coder: coder)
        setCustomView()
    }
}
